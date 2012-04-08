Given /^I am an admin$/ do
  r = Role.create( name: "Admin" )
  @user.roles << r
  @user.save
end

When /^I visit the admin index page$/ do
  visit admin_index_path
end
