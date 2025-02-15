require "nokogiri"
require "fileutils"
require "time"
require "log4r"
require "pp"
require "date"
require "json"

module Vault2git
  GITIGNORE = <<~IGNORED.freeze
    [Oo]bj/
    [Bb]in/
    *.suo
    *.user
    *.vspscc
    *.vssscc
    *.tmp
    *.log
  IGNORED

  # Converts a SourceGear Vault project directory to a Git repository.
  class Converter
    # Configure logging.
    include Log4r

    def initialize(options)
      @options = options

      @stdout_log = StdoutOutputter.new("console")
      @stdout_log.level = INFO

      @file_log = FileOutputter.new("file", filename: @options.logfile, trunc: true)
      @file_log.level = DEBUG

      @logger = Logger.new("vault2git")
      @logger.add(@stdout_log, @file_log)
      %w[debug info warn error fatal].map(&:to_sym).each do |level|
        (class << self; self; end).instance_eval do
          define_method level do |msg|
            @logger.send level, msg
          end
        end
      end

      p options
    end

    def quote_param(param)
      value = @options.send(param)
      quote_value value
    end

    def quote_value(value)
      return "" unless value

      value.include?(" ") ? "\"#{value}\"" : value
    end

    def escape_quotes(str)
      str.gsub "'", "''"
    end

    def vault_command(command, options = [], args = [], append_source_folder = true)
      parts = []
      parts << quote_param(:vault_client)
      parts << command
      %w[host username password repository].each { |param| parts << "-#{param} #{quote_param(param)}" }
      [*options].each { |param| parts << param }
      parts << quote_param(:source) if append_source_folder
      [*args].each { |param| parts << quote_value(param) }
      cmd = parts.join(" ")
      debug "Invoking vault: #{cmd}"
      retryable do
        xml = `#{cmd}`
        doc = Nokogiri::XML(xml) do |config|
          config.strict.noblanks
        end
        raise "Unsuccessful command '#{command}': #{(doc % :error).text}" if (doc % :result)[:success] == "no"

        doc
      rescue StandardError => e
        raise "Error processing command '#{cmd}'", e
      end
    end

    def git_command(command, *options)
      parts = []
      parts << quote_param(:git)
      parts << command
      [*options].each { |param| parts << param }
      cmd = parts.join(" ")
      debug "Invoking git: #{cmd}"
      begin
        debug(retryable { `#{cmd}` })
      rescue StandardError => e
        raise "Error processing command '#{command}'", e
      end
    end

    def git_commit(comments, *options)
      git_command "add", "--all", "."
      params = [*comments].map { |c| "-m \"#{c}\"" } << options << "-a"
      git_command "commit", *params.flatten
    end

    def retryable(max_times = 5, &block)
      tries = 0
      begin
        yield block
      rescue StandardError
        tries += 1
        if tries <= max_times
          warn "Retrying command, take #{tries} of #{max_times}"
          retry
        end
        error "Giving up retrying"
        raise
      end
    end

    def clear_working_folder
      files_to_delete = Dir["#{@options.dest}/*"]
      debug "Removing folders: #{files_to_delete.join(', ')}"
      files_to_delete.each { |d| FileUtils.rm_rf d }
    end

    def convert
      info "Starting at #{Time.now}"
      debug "Parameters: #{@options.inspect}"
      authors = parsed_authors
      info "Prepare destination folder"
      FileUtils.rm_rf @options.dest
      git_command "init", quote_value(@options.dest)
      Dir.chdir @options.dest
      File.open(".gitignore", "w") { |f| f.write(GITIGNORE) }
      git_commit "Starting Vault repository import"

      info "Set Vault working folder"
      vault_command "setworkingfolder", quote_value(@options.source), @options.dest, false

      info "Fetch version history"
      versions = vault_command("versionhistory", ["-rowlimit 0"]) % :history
      versions = versions.children.map do |item|
        hash = {}
        item.attributes.each do |attr|
          hash[attr[0].to_sym] = attr[1].value
        end
        hash
      end

      count = 0
      versions.sort_by { |v| v[:version].to_i }.each_with_index do |version, _i|
        count += 1
        info "Processing version #{count} of #{versions.size}"
        clear_working_folder

        # Fix timestamp format but should be arg.
        vault_command "getversion", ["-backup no", "-merge overwrite", "-setfiletime checkin", "-performdeletions removeworkingcopy", version[:version]], @options.dest
        comments = [version[:comment], "Original Vault commit: version #{version[:version]} on #{version[:date]} by #{version[:user]} (txid=#{version[:txid]})"].compact.map { |c| escape_quotes(c) }
        git_commit comments, "--date=\"#{Time.strptime(version[:date], '%m/%d/%Y %l:%M:%S %p').strftime('%Y-%m-%dT%H:%M:%S')}\"", (authors.key?(version[:user]) ? "--author=\"#{authors[version[:user]]['name']} <#{authors[version[:user]]['email']}>\"" : "")
      end

      info "Ended at #{Time.now}"
    end

    AUTHORS_FILE = "./authors.json".freeze
    def parsed_authors
      authors = {}

      if File.exist? AUTHORS_FILE
        info "Reading authors file"
        authors_file = File.open(AUTHORS_FILE)
        authors_json = authors_file.read
        authors = JSON.parse(authors_json)
      end

      authors
    end
  end
end
