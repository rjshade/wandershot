Feature: Admin
  In order to moderate site content
  As a user with admin rights
  I want to be able to access the admin pages

  Background:
    Given there is a user
    And there is a story
    And there is a post

  Scenario: View admin pages
    Given I am an admin
    And I am logged in
    When I visit the admin index page
    Then I should see "Recent activity"

  Scenario: Unauthorised access
    Given I am logged in
    When I visit the admin index page
    Then I should see "You are not authorized"
