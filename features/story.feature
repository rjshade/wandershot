Feature: Story
  As a user of the site
  I want to create, edit, and view stories
  In order to share my adventures with the world

  Background:
    Given a logged in user

  Scenario: Create a new story
    Given I create a new story
    Then there should be one story

  Scenario: Edit an existing story
    Given I have a story
    And I am on the story page
    And I edit the story
    Then I should see the updated story
