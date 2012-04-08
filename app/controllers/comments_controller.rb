class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user.id

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
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html{ render :nothing => true } 
    end
  end
end
