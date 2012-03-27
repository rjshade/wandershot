Given /^a logged in user$/ do
  @user = User.create!(:name => 'Test User', :email=>'test@user.com', :password => 'please')
  visit(new_user_session_path)
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

And /^I am on the home page$/ do
  visit '/'
end

