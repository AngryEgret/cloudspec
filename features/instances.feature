Feature: Harvest instances
  In order to harvest deviant instances from the command line
  A user should provide the incidents command and path to the creditials

  Scenario: Correctly run the instances command
    Given I run `cloudspec init --path=/tmp`
    When I run `cloudspec amazon instances --yaml=/tmp/config/template.yml --rules=/tmp/rules --mock`
    Then the exit status should be 0
    And the output should contain "INFO -- : Beginning instance harvest ..."
    And the output should contain "INFO -- : Instance harvest complete."

    Given I run `cloudspec init --path=/tmp`
    When I run `cloudspec amazon instances -y /tmp/config/template.yml -r /tmp/rules --mock`
    Then the exit status should be 0
    And the output should contain "INFO -- : Beginning instance harvest ..."
    And the output should contain "INFO -- : Instance harvest complete."

  Scenario: Run the instances command with no parameters
    Given I run `cloudspec init --path=/tmp`
    When I run `cloudspec amazon instances --mock`
    Then the exit status should be 0
    And the output should contain "No value provided for required options"
    And the output should contain "--yaml"
    And the output should contain "--rules"

  Scenario: Run the instances command with a missing credentials file
    Given I run `cloudspec init --path=/tmp`
    When I run `cloudspec amazon instances --yaml=/fail --rules=/tmp/rules --mock`
    Then the exit status should be 1
    And the output should contain "Could not find YAML config file '/fail' (CloudSpec::FileNotFoundError)"

  Scenario: Run the instances command with a missing rules path
    Given I run `cloudspec init --path=/tmp`
    When I run `cloudspec amazon instances --yaml=/tmp/config/template.yml --rules=/fail --mock`
    Then the exit status should be 1
    And the output should contain "Could not find rules path '/fail' (CloudSpec::FileNotFoundError)"
