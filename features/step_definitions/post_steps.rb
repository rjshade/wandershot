Given /^I create a new post$/ do
  click_link ('new-post')
  fill_in('Title', :with => 'My first post title')
  fill_in('Text',  :with => 'Body text of post')
  fill_in('Date',  :with => DateTime.now)
  fill_in('Location',  :with => 'Some place')
  fill_in('Latitude',  :with => '1234')
  fill_in('Longitude', :with => '5678')

  click_button ('Submit')
end

Then /^I should see the post$/ do
  page.should have_content('My first post title')
  page.should have_content('Body text of post')
end

Given /^I have a post$/ do
  @post = FactoryGirl.build(:post, story: @story)
end

Given /^there is a post$/ do
  @post = FactoryGirl.build(:post, story: @story)
end

Given /^I am on the post page$/ do
  visit story_post_path(@story,@post)
end

Given /^I edit the post$/ do
  click_link('Edit')
  fill_in('Title', :with => 'A new post title')
  fill_in('Text', :with => 'New post text')
  click_button('Submit')
end

Then /^I should see the updated post$/ do
  page.should have_content('A new post title')
  page.should have_content('New post text')
end
