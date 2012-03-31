class CommentsController < ApplicationController
  def create
    @story = Story.find_by_slug(params[:story_id])
    @post  = @story.posts.find_by_slug(params[:post_id])
    @parent_comment = @comment

    @comment = Comment.new(params[:comment])
    if @comment.save
      @comment.user = current_user.id
      @post.comments << @comment
      redirect_to [@story,@post], :notice => "Added comment!"
    else
      redirect_to [@story,@post], :notice => "Fail."
    end
  end
end
