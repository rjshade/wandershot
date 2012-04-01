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

  def destroy
    @comment = current_user.comments.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      redirect_to [@post.story,@post], :notice => "Deleted comment"
    else
      redirect_to [@post.story,@post], :notice => "Failed to delete comment."
    end
  end
end
