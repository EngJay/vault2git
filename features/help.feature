Feature: Help
    In order to provide helpful info
    As a CLI
    I want to display helpful info

Scenario: CLI is run without any options or arguments
    When I run `vault2git`
    Then the output should contain "help"

Scenario: CLI is run with the long help option
    When I run `vault2git --help`
    Then the output should contain "help"

Scenario: CLI is run with the short help option
    When I run `vault2git -h`
    Then the output should contain "help"
