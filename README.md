# vault2git

Creates a Git repository from a SourceGear Vault repository.

[![codecov](https://codecov.io/gh/EngJay/vault2git/branch/main/graph/badge.svg?token=6U63HP2JUE)](https://codecov.io/gh/EngJay/vault2git)

## About

TODO

## Usage

Launch the app with `ruby vault2git` and you'll see the help screen which should be enough to get you started. An example might be:

```bash
$ bundle exec ruby vault2git --host localhost \
                             --repo "My Repo" \
                             $/Vault/Folder c:/New/Git/Repo
```

Wrap parameter values in double-quotes as required. _IMPORTANT: the paths MUST use forward slashes to delimit folders even in Windows._

## Process

The conversion process is pretty BFI-y. Given a Vault repository, it creates a new Git repository, fetches the list of Vault versions, then iterates through each of the versions performing the following steps:

- clear out the Git repository folder (except `.git*` files)
- fetch the current version's files from Vault
- add and commit the version to Git, including a descriptive comment

The comments written to Git include the original Vault comments (if any) plus a one-liner containing the original Vault version number, check-in time, etc. The original Vault check-in time is used as the commit's time.

Clearly this isn't an optimal algorithm, but it works. And really, how often are you going to do this? I have one project that has hundreds of source files AND some large binary library files with over 500 versions, and it runs in something like eight hours. But it works so I'm happy.

## Requirements

TODO Change to prereqs and move to better location.

- Vault client installed (uses the command-line client)
- Ruby 3.1.2
- Bundler gem: installed dependencies with `bundle install`

<!-- Default reamdme generated by bundler for gem. -->
<!-- 
# Vault2git

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/vault2git`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add vault2git

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install vault2git

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vault2git. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/vault2git/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vault2git project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vault2git/blob/master/CODE_OF_CONDUCT.md). -->
