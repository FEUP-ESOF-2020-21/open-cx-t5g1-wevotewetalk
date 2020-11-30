Feature: Brainstorm
  User should be able to send theme suggestions

  Scenario: User sends theme idea
    Given I am on the main menu page
    When I press the brainstorm button
    And I type "testtheme" in the text field
    And I press the send button
    Then "testtheme" should be added to the theme list