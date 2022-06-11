require "rubygems"
require "bundler"
require "./options"
require "./converter"

options = Options.new
converter = Converter.new(options.options)
converter.convert
