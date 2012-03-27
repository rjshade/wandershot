Given /^I click the join button$/ do
  click_link 'join-button'
end

Then /^I enter my details$/ do
  page.should have_content('Sign up')
  fill_in('Name', :with => 'First User')
  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'please')
  fill_in('Password confirmation', :with => 'please')
  click_button ('Create account')
end

Then /^I should be welcomed to the site$/ do
  page.should have_content('Welcome! You have signed up successfully.')
end
