Feature: Comments
  In order to communicate my insightful views
  As a user of the site
  I want to be able to comment on posts

  Background:
    Given there is a user
    And there is a story
    And there is a post

  Scenario: Add a Post comment
    Given I am logged in
    And I am on the post page
    When I comment on the post
    Then the post should have a comment
    Then I should see the comment

  Scenario: Add a Story comment
    Given I am logged in
    And I am on the story page
    When I comment on the story
    Then the story should have a comment
    Then I should see the comment
