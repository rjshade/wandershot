class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post][:id])

    @comment = Comment.new(params[:comment])
    @comment.user = current_user.id
    @post.comments << @comment

    @comment.save

    respond_to do |format|
      format.html{ render :partial => 'comments/show', :locals => { :comment => @comment } }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html{ render :nothing => true } 
    end
  end
end
