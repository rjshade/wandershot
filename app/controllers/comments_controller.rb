class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post][:id])

    @comment = Comment.new(params[:comment])
    if @comment.save
      @comment.user = current_user.id
      @post.comments << @comment
      redirect_to [@post.story,@post], :notice => "Added comment!"
    else
      redirect_to [@post.story,@post], :notice => "Fail."
    end
  end
end
