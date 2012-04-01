Feature: Post
  As a user of the site
  I want to create, edit, and view posts in an existing story
  In order to share my adventures with the world

  Background:
    Given a logged in user
    Given I have a story

  Scenario: Create a new post
    Given I am on the story page
    And I create a new post
    # on the new post page
    Then I should see the post
    And I am on the story page
    # on the story page
    Then I should see the post

  Scenario: Edit an existing post
    Given I have a post
    And I am on the post page
    And I edit the post
    Then I should see the updated post
