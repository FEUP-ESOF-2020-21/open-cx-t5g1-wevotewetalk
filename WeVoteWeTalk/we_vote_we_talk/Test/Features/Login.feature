Feature: Login
  User should be able to login if the email and password are correct

  Scenario: User login fail
    Given I am on the login page
    When I type "diogo@test.mail" in the email field
    And I type "wrongpassword" in the password field
    And I press the login button
    Then User is not logged in

  Scenario: User login
    Given I am on the login page
    When I type "diogo@test.mail" in the email field
    And I type "diogoreis" in the password field
    And I press the login button
    Then User is logged in

