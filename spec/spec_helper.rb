# frozen_string_literal: true

require "vault2git"
require "logger"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Redirects puts to a null object.
#
# Usage:
#
#   before do
#     suppress_log_output
#   end
def suppress_log_output
  allow($stdout).to receive(:puts) # Disables puts.
  logger = double("Logger").as_null_object
  allow(Logger).to receive(:new).and_return(logger)
end
