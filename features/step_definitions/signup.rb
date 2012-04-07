Given /^I click the join button$/ do
  click_link 'Sign up'
end

Then /^I enter my details$/ do
  page.should have_content('Sign up')
  fill_in('Name', :with => 'First User')
  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'please')
  fill_in('Password confirmation', :with => 'please')
  click_button ('Create account')
end

Then /^I should be told to confirm my email$/ do
  page.should have_content('confirmation link has been sent')
end
