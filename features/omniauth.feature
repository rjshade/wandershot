@omniauth
Feature: Omniauth
  In order to login conveniently
  As a site visitor
  I want to authenticate with Facebook

  Scenario: Signed in and link account
    Given I am a logged in user
    And I am on the account settings page
    When I connect to Facebook
    Then I have a new authentication
    And I can see the authentication on my account settings page

  Scenario: Sign in with authentication
    Given I have an account
    And I have an authentication
    And I am on the login page
    When I connect to Facebook
    Then I should see "You are now signed in"

  Scenario: Link with matching email
    Given I have an account
    And my Facebook email is the same as my account email
    And I am on the login page
    When I connect to Facebook
    Then I should see "Your account is now linked to your Facebook account"

  Scenario: Merge with existing account
    Given I have an account
    And I am on the login page
    When I connect to Facebook
    And I merge my account
    Then I should see "You can now sign in using your Facebook account"
    And I have a new authentication

  Scenario: Create a new account via authentication
    Given I am an unknown visitor
    And I am on the login page
    When I connect to Facebook
    And I create an account
    Then I should see "We've linked your Facebook account"
    And I get an email
