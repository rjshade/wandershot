Given /^I create a new post$/ do
  click_link ('New post')
  fill_in('Title', :with => 'My first post title')
  fill_in('Text',  :with => 'Body text of post')
  click_button ('Create Post')
end

Then /^I should see the post$/ do
  page.should have_content('My first post title')
  page.should have_content('Body text of post')
end
