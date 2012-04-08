Given /^I create a new story$/ do
  click_link ('New story')
  fill_in('Title', :with => 'My Super Story')
  fill_in('Summary', :with => 'This is an exciting description.')
  click_button ('Submit')
end

Given /^I have a story$/ do
  @story = Story.create!(:title => 'My first story', :summary => 'An exciting summary', :user => @user )
end

Given /^there is a story$/ do
  @story = Story.create!(:title => 'My first story', :summary => 'An exciting summary', :user => @user )
end

Then /^there should be one story$/ do
  Story.all.size.should == 1
end

Given /^I edit the story$/ do
  visit edit_story_path @story
  fill_in('Title', :with => 'A new title')
  fill_in('Summary', :with => 'A new summary')
  click_button('Submit')
end

Then /^I should see the updated story$/ do
  page.should have_content('A new title')
  page.should have_content('A new summary')
end

And /^I am on the stories page$/ do
  visit stories_path
end

And /^I am on the story page$/ do
  visit story_path @story
end

