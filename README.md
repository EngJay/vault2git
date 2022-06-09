# vault2git

Creates a Git repository from a SourceGear Vault repository.

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
