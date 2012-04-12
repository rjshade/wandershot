class UsersController < ApplicationController
  def show
    @user = User.find_by_slug(params[:id])
  end

  def index
    @users = User.all
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
