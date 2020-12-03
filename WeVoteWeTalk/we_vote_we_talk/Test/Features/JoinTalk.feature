Feature: JoinTalk
  User should be able to join a talk

  Scenario: User join talk
    Given I am on the main menu page
    When I press the join talks button
    And I press a theme button
    And I press the join meeting button
    Then User joined a talk on jitsi