class HomeController < ApplicationController
  def index
    @users = User.all
    @post_main = Post.all.shuffle.first
    @post_second = Post.all.shuffle.first
    @post_third = Post.all.shuffle.first
  end
end
