Given /^I am an admin$/ do
  r = Role.create( name: "Admin" )
  @user.roles << r
  @user.save
end
