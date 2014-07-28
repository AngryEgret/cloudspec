Feature: Harvest instances
  In order to harvest deviant instances from the command line
  A user should provide the incidents command and path to the creditials

  Scenario: Correctly run the instances command
    When I run `skim_reaper instances --yaml=/dev/null`
    Then the exit status should be 0
    And the output should contain "INFO -- : Beginning instance harvest ..."
    And the output should contain "INFO -- : Instance harvest complete."

    When I run `skim_reaper instances -y /dev/null`
    Then the exit status should be 0
    And the output should contain "INFO -- : Beginning instance harvest ..."
    And the output should contain "INFO -- : Instance harvest complete."

  Scenario: Run the instances command with no --yaml parameter
    When I run `skim_reaper instances`
    Then the exit status should be 0
    And the output should contain "No value provided for required options '--yaml'"

  Scenario: Run the instances command with a missing credentials file
    When I run `skim_reaper instances --yaml=/fail`
    Then the exit status should be 1
    And the output should contain "Could not find YAML config file '/fail' (SkimReaper::FileNotFoundError)"
