# frozen_string_literal: true

require "vault2git"
require "vault2git/options"

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

# RSpec.describe Vault2git::Converter do
# it "should exit cleanly when instantiated without arguments" do
#   expect { Vault2git::Options.new }.to raise_error(SystemExit) do |error|
#     expect(error.status).to eq(0) # Clean exit.
#   end
# end
# end
