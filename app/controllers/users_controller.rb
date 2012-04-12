class UsersController < ApplicationController
  def show
    @user = User.find_by_slug(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @users = current_user
  end
end
