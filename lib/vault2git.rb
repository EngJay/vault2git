# frozen_string_literal: true

require_relative "vault2git/version"
require_relative "vault2git/options"
require_relative "vault2git/converter"

module Vault2git
  class Error < StandardError; end
  # Your code goes here...
end

# Old top-level script:
#
# require "rubygems"
# require "bundler"
# require "./options"
# require "./converter"

# options = Options.new
# converter = Converter.new(options.options)
# converter.convert
