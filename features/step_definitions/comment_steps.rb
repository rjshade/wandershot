When /^I comment on the post$/ do
  fill_in('comment_text', :with => 'I can haz comment?')
  click_button('submit')
end

When /^I comment on the story$/ do
  fill_in('comment_text', :with => 'I can haz comment?')
  click_button('submit')
end

Then /^the story should have a comment$/ do
  @story.comments.last.text.should == "I can haz comment?"
end

Then /^the post should have a comment$/ do
  @post.comments.last.text.should == "I can haz comment?"
end

Then /^I should see the comment$/ do
  page.should have_content('I can haz comment?')
end

