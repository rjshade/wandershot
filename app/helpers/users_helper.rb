module UsersHelper
  def link_to_user(user)
    link_to user.name, user_path(user)
  end
end
