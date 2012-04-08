class AdminController < ApplicationController
  before_filter :authenticate_user!

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
end
