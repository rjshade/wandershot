Given /^I click the join button$/ do
  click_link 'join-button'
end

Then /^I should see the signup form$/ do
  page.should have_content('Sign up')
end
