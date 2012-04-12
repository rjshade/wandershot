Given /^there is a user$/ do
  @user = FactoryGirl.build( :user )
  @user.confirm!
end

Given /^I have an account$/ do
  @user = FactoryGirl.build( :user )
  @user.confirm!
end

Given /^I am a logged in user$/ do
  name = 'Test User'
  email = 'test.user@example.com'
  password = 'please'
  @user = User.create(name: name, email: email, password: password, password_confirmation: password)
  @user.confirm!

  visit(new_user_session_path)
  fill_in('Email',    :with => email)
  fill_in('Password', :with => password)

  click_button('Sign in')
end

Given /^I am logged in$/ do
  visit(new_user_session_path)
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

Given /^I update my details$/ do
  fill_in('Name', :with => 'Changed Name')
  fill_in('Email', :with => 'new@email.com')
  fill_in('Current password', :with => 'please')
  click_button('Update account')
end

Then /^I should see the new details$/ do
  page.should have_content('You updated your account successfully')
  visit edit_user_registration_path
  page.should have_content('Changed Name')
end

And /^there should be one user$/ do
  User.all.size.should == 1
end
