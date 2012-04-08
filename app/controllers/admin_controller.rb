class AdminController < ApplicationController
  before_filter :authenticate

  def index
  end

  def stories
    @stories = Story.all
  end

  def posts
    @posts = Post.all
  end

  def users
    @users = User.all
  end

  def comments
    @comments = Comment.all
  end

  private
    def authenticate
      authorize! :access, :admin
    end
end
