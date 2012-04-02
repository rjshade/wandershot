class RegistrationsController < Devise::RegistrationsController
  def new
    session[:user_return_to] ||= request.referer
    super
  end
end
