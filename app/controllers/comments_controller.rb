class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    if current_user
      @comment.user = current_user.id
    end

    if params[:post]
      @post = Post.find(params[:post][:id])
      @post.comments << @comment
    elsif params[:story]
      @story = Story.find(params[:story][:id])
      @story.comments << @comment
    end

    @comment.save

    respond_to do |format|
      format.html{ render :partial => 'comments/show', :locals => { :comment => @comment } }
    end
  end

  def destroy
    authenticate_user!
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html{ render :nothing => true } 
    end
  end
end
