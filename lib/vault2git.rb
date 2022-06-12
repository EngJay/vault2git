# frozen_string_literal: true

require_relative "vault2git/version"
require_relative "vault2git/options"
require_relative "vault2git/converter"

module Vault2git
  # CLI entry point.
  class CLI
    def self.start
      options = Options.new
      converter = Converter.new(options.options)
      converter.convert
    end
  end
end
