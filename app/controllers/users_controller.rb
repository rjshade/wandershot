class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def show
    @user = User.find_by_slug(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @users = current_user
  end

  def destroy
    @user = User.find_by_slug(params[:id])
    flash[:notice] = "User #{@user.name} deleted successfully"
    @user.destroy
    redirect_to :root
  end
end
