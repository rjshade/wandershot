When /^I comment on the post$/ do
  fill_in('Add comment', :with => 'I can haz comment?')
  click_button('Create Comment')
end

Then /^I should see the comment$/ do
  page.should have_content('I can haz comment?')
end
