# Quick Start Guide

These instructions were made on Windows but they should be similar on other platforms.

### Have Ruby installed (see .ruby-version)

A Ruby version manager of some kind is recommended.

### Install dependencies

```bash
$ gem install bundler
```

```bash
$ bundle install
```

### Locate your installation of SourceGear Vault Client.

You can edit the `options.rb` file to set this value if it differs from the default. It's not necessary but saves you from having to include on the command line every time.

### Create the folder structure for where you want your new git repository to be created.

Invoke the vault2git script via the CLI.

```bash
$ bundle exec ruby vault2git.rb --host VAULT_SERVER          \
                                --repo VAULT_REPOSITORY_NANE \
                                -u VAULT_USER                \
                                -p VAULT_PASSWORD            \
                                VAULT_SOURCE GIT_DESTINATION
```

```bash
$ bundle exec ruby vault2git.rb --host localhost            \
                                --repo "Initial Repository" \
                                -u user                     \
                                -p password                 \
                                $/Apps/Alpha C:/source/git/Alpha
```

You might need some additional clean up steps to remove the Vault bindings from your projects. For example, Visual Studio embeds Vault source control information in solutions and project files.
