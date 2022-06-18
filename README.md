<h1 align="center">
  <a href="https://github.com/EngJay/vault2git">
    <!-- Please provide path to your logo here -->
    <img src="docs/images/logo.svg" alt="Logo" width="100" height="100">
  </a>
</h1>

<div align="center">
  vault2git
  <br />
  <br />
  <a href="https://github.com/EngJay/vault2git/issues/new?assignees=&labels=bug&template=01_DEFECT_REPORT.md&title=Defect%3A+">Report a Defect</a>
  ·
  <a href="https://github.com/EngJay/vault2git/issues/new?assignees=&labels=enhancement&template=02_FEATURE_REQUEST.md&title=feat%3A+">Request a Feature</a>
  .
  <a href="https://github.com/EngJay/vault2git/issues/new?assignees=&labels=question&template=04_QUESTION.md&title=quest%3A+">Ask a Question</a>
</div>

<div align="center">
<br />

[![Project license](https://img.shields.io/github/license/EngJay/vault2git.svg?style=flat-square)](LICENSE.txt)

[![Pull Requests welcome](https://img.shields.io/badge/PRs-welcome-ff69b4.svg?style=flat-square)](https://github.com/EngJay/vault2git/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22)
[![made with love by EngJay](https://img.shields.io/badge/made%20with%20%E2%99%A5%20by-EngJay-ff1414.svg?style=flat-square)](https://github.com/EngJay)

[![codecov](https://codecov.io/gh/EngJay/vault2git/branch/main/graph/badge.svg?token=6U63HP2JUE)](https://codecov.io/gh/EngJay/vault2git)

</div>

<details open="open">
<summary>Table of Contents</summary>

- [About](#about)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Support](#support)
- [Project assistance](#project-assistance)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)
- [Acknowledgements](#acknowledgements)

</details>

---

## About

The vault2git project provides a simple command line tool for migrating a
[SourceGear Vault](http://www.sourcegear.com/vault/) project to a
[Git](https://git-scm.com/) repository.

This fork of the original Ruby port by @slamotte updates the dependencies to
current, adds quality control, converts the script to a RubyGem, and will
add additional features in subsequent releases.

Ultimately, the aim is to provide a simple to use, high-quality command line
tool for migrating a project from SourceGear Vault to Git in high-scrutiny 
contexts. The key new feature planned is automatic validation of a migration
by generating and comparing hashes of each Vault check-in against the 
correpsonding Git commit.

### Process

Given a Vault project path, it creates a new Git repository, fetches the list of Vault check-ins, then iterates through each of the check-ins performing the following steps:

- clear out the Git repository folder (except `.git*` files)
- fetch the current check-in's files from Vault
- add and commit the files to Git, including a commit message that is either the message associated with the Vault check-in or its metadata. 

The comments written to Git include the original Vault comments (if any) plus a one-liner containing the original Vault version number, check-in time, etc. The original Vault check-in time is used as the commit's time.

### Built With

- Ruby
- log4r
- nokogiri

## Getting Started

### Prerequisites

- Have Git installed.
- Have a SourceGear Vault client installed. 
- Have the current stable version of Ruby (3.1.2).

### Installation

To install vault2git, install the gem at the user level.

```
$ bundle install --user-install vault2git
```

## Usage

```
Usage: vault2git [options] $/source/folder dest/folder

Specific options:
    -s, --host host                  The repository hostname/ip address
    -r, --repo name                  The repository name
    -u, --username [username]        The repository user
    -p, --password [password]        The repository user's password
        --vault-client-path path-to-vault.exe
                                     Path to vault.exe, defaults to C:\Program Files\SourceGear\Vault Client\vault.exe
        --git-path path-to-git.exe   Path to git.exe, defaults to git
        --logfile filename           File to log to (defaults to vault2git.log)
    -h, --help                       Display this help screen
```

Wrap parameter values in double-quotes as required. _IMPORTANT: the paths MUST use forward slashes to delimit folders even in Windows._

## Support

Reach out to the maintainer by opening an 
[issue](https://github.com/EngJay/vault2git/issues/new?assignees=&labels=question&template=04_QUESTION.md&title=support%3A+).

## Project Assistance

If you want to say **thank you** or/and support active development of vault2git:

- Add a [GitHub Star](https://github.com/EngJay/vault2git) to the project.
- Tweet about [vault2git](https://github.com/EngJay/vault2git).
- Write articles including the project on [Dev.to](https://dev.to/), [Medium](https://medium.com/) or your personal blog.

## Contributing

First off, thanks for taking the time to contribute! Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make will benefit everybody else and are **greatly appreciated**.


Please read [our contribution guidelines](docs/CONTRIBUTING.md), and thank you for being involved!

## Security

This project follows good practices of security, but 100% security cannot be assured. The vault2git RubyGem is provided **"as is"** without any **warranty**. Use at your own risk.

_For more information and to report security issues, please refer to our [security documentation](docs/SECURITY.md)._

## License

This project is licensed under the **MIT license**.

See [LICENSE](LICENSE.txt) for more information.

## Acknowledgements

This appears to be the original C# project: [vault2git](https://github.com/AndreyNikiforov/vault2git) by Andrey Nikiforov ([@AndreyNikiforov](https://github.com/AndreyNikiforov)) and Jevgeni Zelenkov ([@jayzelenkov](https://github.com/jayzelenkov)).  

Contribution of the original [Ruby port](https://github.com/slamotte/vault2git) from which this project is forked:  Steve Lamotte ([@slamotte](https://github.com/slamotte))
