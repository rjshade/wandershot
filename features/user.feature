Feature: Account settings
  In order to update my details
  I want to edit my account settings
  As a signed in user

  Scenario:
    Given I am a logged in user
    And I am on the account settings page
    And I update my details
    Then I should see the new details
