class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def callback
    omniauth = request.env['omniauth.auth']
    auth = Authentication.where({provider: omniauth['provider'], uid: omniauth['uid']}).first
    if auth
      flash[:"alert-success"] = t(:signed_in)
      sign_in_and_redirect(:user, auth.user)  
    elsif current_user
      current_user.authentications.find_or_create_by( provider: omniauth['provider'], uid: omniauth['uid'])
      flash[:"alert-success"] = t(:auth_facebook_success)
      redirect_to edit_user_registration_path current_user
    elsif user = User.where( email: omniauth['info']['email'] ).first
      user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user.save!
      flash[:"alert-success"] = t(:auth_facebook_linked) 
      sign_in_and_redirect(:user, user)  
    else
      # store omniauth data in session
      # the 'extra' field can be too big to fit in the session so we drop it
      # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
      session[:omniauth] = omniauth.except('extra')
      redirect_to auth_merge_url
    end  
  end

  def create_new_account
    omniauth = session[:omniauth]
    if omniauth
      pwd = (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
      user = User.new(:name => omniauth['info']['name'], :email => omniauth['info']['email'], :password => pwd, :password_confirmation =>pwd)  
      user.omniauth_signup = true
      user.skip_confirmation!
      user.save

      user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])  

      #UserMailer.welcome_email(user).deliver!

      flash[:"alert-success"] = t(:auth_facebook_created) 
      sign_in_and_redirect(:user, user) # devise helper method
    else
      redirect_to new_user_registration_path
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    flash[:notice] = t(:auth_facebook_destroy)

    @authentication.destroy
    redirect_to edit_user_registration_path
  end

  def failure
    flash[:notice] = "Failed to authenticate! Message was: '#{params[:message]}'"
    redirect_to edit_user_registration_path
  end
  
  def merge
    if session[:omniauth]
      # want the user to be redirected to account edit page on sign-in
      session[:user_return_to] = edit_registration_path :user
      render 'merge'
    else
      redirect_to new_user_registration_path
    end
  end
end
