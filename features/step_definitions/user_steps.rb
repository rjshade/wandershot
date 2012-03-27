Given /^a logged in user$/ do
  @user = User.create!(:name => 'Test User', :email=>'test@user.com', :password => 'please')
  visit(new_user_session_path)
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

Given /^I create a new story$/ do
  click_link ('New story')
  fill_in('Title', :with => 'My Super Story')
  fill_in('Summary', :with => 'This is an exciting description.')
  click_button ('Create Story')
end

Then /^there should be one story$/ do
  Story.all.size.should == 1
end

Given /^I have a story$/ do
  @story = Story.create!(:title => 'My first story', :summary => 'An exciting summary', :user => @user )
end

And /^I am on the home page$/ do
  visit '/'
end

And /^I am on the stories page$/ do
  visit stories_path
end

And /^I am on the story page$/ do
  visit story_path @story
end

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
