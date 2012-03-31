class CommentsController < ApplicationController
  def create
    @story = Story.find_by_slug(params[:story_id])
    @post  = @story.posts.find_by_slug(params[:post_id])
    @parent_comment = @comment

    @comment = Comment.new(params[:comment])
    @comment.user = current_user.id

    @post.comments << @comment

    redirect_to [@story,@post], :notice => "Added comment!"
  end
end
