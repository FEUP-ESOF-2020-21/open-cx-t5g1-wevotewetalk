Feature: Register
  User should be able to register if the email and password are valid

  Scenario: User register
    Given I am on the register page
    When I type "newemail@test.mail" in the email field
    And I type "newpassword" in the password field
    And I press the register button
    Then User is added to the database