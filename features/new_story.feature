Feature: New Story
  Background:
    Given a logged in user

  Scenario: Create a new story
    Given I am on the stories page
    And I create a new story
    Then there should be one story

  Scenario: Create a new post
    Given I have a story
    And I am on the story page
    And I create a new post
    Then I should see the post
