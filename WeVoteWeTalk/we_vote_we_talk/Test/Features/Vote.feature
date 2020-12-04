Feature: Vote
  User should be able to vote on the themes

  Scenario: User votes on theme
    Given I am on the vote page
    When I press a "theme" button I like
    Then "theme" vote value should be incremented