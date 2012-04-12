Then /^(?:|I )should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

And /^I am on the home page$/ do
  visit '/'
end

And /^I am on the account settings page$/ do
  visit edit_user_registration_path
end

And /^I am on my profile page$/ do
  visit user_path @user
end

And /^I am on the login page$/ do
  visit new_user_session_path
end

When /^I visit the admin index page$/ do
  visit admin_index_path
end


