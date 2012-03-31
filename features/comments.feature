Feature: Comments
  In order to communicate my insightful views
  As a user of the site
  I want to be able to comment on posts

  Scenario: Post comment
    Given there is a post
    And I am signed in
    When I comment on the post
    Then I should see the comment
