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

    # expect(options.username).to eq("")
    # expect(options.password).to eq("")
    # expect(options.vault_client).to eq('C:\\Program Files\\SourceGear\\Vault Client\\vault.exe')
    # expect(options.git).to eq("git")
    # expect(options.logfile).to eq("vault2git.log")
  end
end
