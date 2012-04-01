Given /^there is a user$/ do
  @user = User.create!(:name => 'Test User', :email=>'test@user.com', :password => 'please')
end

Given /^a logged in user$/ do
  @user = User.create!(:name => 'Test User', :email=>'test@user.com', :password => 'please')
  visit(new_user_session_path)
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

Given /^I am logged in$/ do
  visit(new_user_session_path)
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

And /^I am on the home page$/ do
  visit '/'
end

And /^I am on the account settings page$/ do
  visit edit_user_registration_path
end

Given /^I update my details$/ do
  fill_in('Name', :with => 'Changed Name')
  fill_in('Email', :with => 'new@email.com')
  fill_in('Current password', :with => 'please')
  click_button('Update account')
end

Then /^I should see the new details$/ do
  page.should have_content('You updated your account successfully.')
  visit edit_user_registration_path
  page.should have_content('Changed Name')
end
