Feature: Sign in
  In order to make a purchase
  A User
  Should be able to sign in

  Scenario: User signs in successfully
    Given I am signed up as "email@person.com/password"
    When I go to the sign in page
    And I sign in as "email@person.com/password"
    Then I should see "Logged in successfully"
    And I should be signed in

  Scenario: User is not signed up
    Given no user exists with an email of "email@person.com"
    When I go to the sign in page
    And I sign in as "email@person.com/password"
    Then I should see "Invalid email or password"
    And I should be signed out

  Scenario: User enters wrong password
    Given I am signed up as "email@person.com/password"
    When I go to the sign in page
    And I sign in as "email@person.com/wrongpassword"
    Then I should see "Invalid email or password"
    And I should be signed out

  Scenario: User requests a restricted page with the correct password
    Given I have an admin account of "email@person.com/password"
    When I go to the admin home page
    And I sign in as "email@person.com/password"
    Then I should be on the admin home page