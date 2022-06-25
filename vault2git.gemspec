# frozen_string_literal: true

require_relative "lib/vault2git/version"

Gem::Specification.new do |spec|
  spec.name = "vault2git"
  spec.version = Vault2git::VERSION
  spec.authors = ["Jason Scott"]
  spec.email = [""]

  spec.summary = "SourcGear Vault project to Git repo converter."
  spec.homepage = "https://github.com/EngJay/vault2git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/EngJay/vault2git"
  spec.metadata["changelog_uri"] = "https://github.com/EngJay/vault2git/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "log4r", "~> 1.1"
  spec.add_dependency "nokogiri", "~> 1.13"

  spec.add_development_dependency "aruba", "~> 2.1"
  spec.add_development_dependency "codecov", "~> 0.6.0"
  spec.add_development_dependency "cucumber", "~> 8.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop-github", "~> 0.17"
  spec.add_development_dependency "rubocop-performance", "~> 1.14"
  spec.add_development_dependency "rubocop-rails", "~> 2.14"
  spec.add_development_dependency "rubocop-rake", "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.11"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "sinatra", "~> 2.2.0"
  spec.add_development_dependency "webmock", "~> 3.14.0"
end
