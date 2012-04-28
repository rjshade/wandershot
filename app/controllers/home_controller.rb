class HomeController < ApplicationController
  def index
    @users = User.all
    @main_post = Post.with_images.to_a.shuffle.first
    @user = User.new
  end
end
