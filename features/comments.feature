Feature: Comments
  In order to communicate my insightful views
  As a user of the site
  I want to be able to comment on posts

  Background:
    Given there is a user
    And there is a story
    And there is a post

  Scenario: Post comment
    Given I am logged in
    And I am on the post page
    When I comment on the post
    Then I should see the comment
