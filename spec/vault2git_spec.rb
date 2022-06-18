# frozen_string_literal: true

require "vault2git"
require "vault2git/options"
require "vault2git/converter"

RSpec.describe Vault2git do
  it "has a version number" do
    expect(Vault2git::VERSION).not_to be nil
  end
end

RSpec.describe Vault2git::Options do
  before do
    suppress_log_output
  end

  it "should exit cleanly when instantiated without arguments" do
    expect { Vault2git::Options.new }.to raise_error(SystemExit) do |error|
      expect(error.status).to eq(0) # Clean exit.
    end
  end

  it "should exit cleanly when instantiated with one argument" do
    # Remove the "spec" arg set by rspec.
    ARGV.clear
    ARGV.append("spec_source")

    expect { Vault2git::Options.new }.to raise_error(SystemExit) do |error|
      expect(error.status).to eq(0) # Clean exit.
    end
  end

  it "should construct options with defaults with two arguments and no options" do
    # Remove the "spec" arg set by rspec.
    ARGV.clear
    ARGV.append("spec_source")
    ARGV.append("spec_dest")

    options = Vault2git::Options.new.options

    expect(options.username).to eq("")
    expect(options.password).to eq("")
    expect(options.vault_client).to eq('C:\\Program Files\\SourceGear\\Vault Client\\vault.exe')
    expect(options.git).to eq("git")
    expect(options.logfile).to eq("vault2git.log")
  end

  it "should construct options with defaults with two arguments and username and password" do
    # Remove the "spec" arg set by rspec, then set just the source arg.
    ARGV.clear
    ARGV.append("--username")
    ARGV.append("mr_the_plague")
    ARGV.append("--password")
    ARGV.append("acid_burn")
    ARGV.append("spec_source")
    ARGV.append("spec_dest")

    options = Vault2git::Options.new.options

    expect(options.username).to eq("mr_the_plague")
    expect(options.password).to eq("acid_burn")
    expect(options.vault_client).to eq("C:\\Program Files\\SourceGear\\Vault Client\\vault.exe")
    expect(options.git).to eq("git")
    expect(options.logfile).to eq("vault2git.log")
  end

  it "should construct options with two arguments and additonal options" do
    # Remove the "spec" arg set by rspec, then set just the source arg.
    ARGV.clear
    ARGV.append("--username")
    ARGV.append("mr_the_plague")
    ARGV.append("--password")
    ARGV.append("acid_burn")
    ARGV.append("--vault-client-path")
    ARGV.append("C:\\hack\\the\\planet.exe")
    ARGV.append("--git-path")
    ARGV.append("non\\standard\\git\\path")
    ARGV.append("--logfile")
    ARGV.append("non-default-filename.txt")
    ARGV.append("spec_source")
    ARGV.append("spec_dest")

    options = Vault2git::Options.new.options

    expect(options.username).to eq("mr_the_plague")
    expect(options.password).to eq("acid_burn")
    expect(options.vault_client).to eq("C:\\hack\\the\\planet.exe")
    expect(options.git).to eq("non\\standard\\git\\path")
    expect(options.logfile).to eq("non-default-filename.txt")
  end
end

RSpec.describe Vault2git::Converter do
  before do
    suppress_log_output

    # Remove the "spec" arg set by rspec, then set just the source arg.
    ARGV.clear
    ARGV.append("--username")
    ARGV.append("mr_the_plague")
    ARGV.append("--password")
    ARGV.append("acid_burn")
    ARGV.append("--vault-client-path")
    ARGV.append("C:\\hack\\the\\planet.exe")
    ARGV.append("--git-path")
    ARGV.append("non\\standard\\git\\path")
    ARGV.append("--logfile")
    ARGV.append("non-default-filename.txt")
    ARGV.append("spec_source")
    ARGV.append("spec_dest")

    @options = Vault2git::Options.new.options
    @converter = Vault2git::Converter.new(@options)
  end

  describe "#quote_param" do
    it "should return the values of the options" do
      expected_username = @converter.quote_param(:username)
      expect(expected_username).to eq("mr_the_plague")

      expected_password = @converter.quote_param(:password)
      expect(expected_password).to eq("acid_burn")

      expected_vault_client = @converter.quote_param(:vault_client)
      expect(expected_vault_client).to eq("C:\\hack\\the\\planet.exe")

      expected_git = @converter.quote_param(:git)
      expect(expected_git).to eq("non\\standard\\git\\path")

      expected_logfile = @converter.quote_param(:logfile)
      expect(expected_logfile).to eq("non-default-filename.txt")
    end

    it "should return the values of the arguments" do
      expected_source = @converter.quote_param(:source)
      expect(expected_source).to eq("spec_source")

      expected_dest = @converter.quote_param(:dest)
      expect(expected_dest).to eq("spec_dest")
    end
  end

  describe "#quote_value" do
    it "should return an empty string if passed nil" do
      expected_empty_string = @converter.quote_value(nil)
      expect(expected_empty_string).to eq("")
    end

    it "should return an empty string if passed an empty string" do
      expected_empty_string = @converter.quote_value("")
      expect(expected_empty_string).to eq("")
    end

    it "should return the argument if passed an argument without a space" do
      expected_without_a_space = @converter.quote_value("Spaceless!")
      expect(expected_without_a_space).to eq("Spaceless!")
    end

    it "should return the argument wrapped in quotes if passed an argument with a space" do
      expected_arg_with_quotes = @converter.quote_value("Has space!")
      expect(expected_arg_with_quotes).to eq("\"Has space!\"")
    end
  end

  # describe "#parsed_authors" do
  #   it "should return the parsed authors given a authors.json file" do
  #     allow(File).to receive(:exists?).and_return(true)
  #     # allow(JSON).to receive(:parse).with(AUTHORS_JSON)

  #     @converter.parsed_authors

  #     expect(File).to have_received(:exists?).with("./authors.json")
  #     # expect(File).to have_received(:parse).with(AUTHORS_JSON)
  #   end
  # end
end
