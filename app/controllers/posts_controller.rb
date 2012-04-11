class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @posts = Post.with_images.shuffle
  end

  def show
    @story = Story.find_by_slug(params[:story_id])
    @post  = @story.posts.find_by_slug(params[:id])
    @comments = @post.comments.latest
  end

  def new
    @story = Story.find_by_slug(params[:story_id])
    @post = @story.posts.build
  end

  def create
    @story = Story.find_by_slug(params[:story_id])
    @post = @story.posts.build(params[:post])

    if @post.save
      redirect_to [@story,@post], notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @story = Story.find_by_slug(params[:story_id])
    @post = @story.posts.find_by_slug(params[:id])
  end

  def update
    @story = Story.find_by_slug(params[:story_id])
    @post = @story.posts.find_by_slug(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to [@story,@post], notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @story = Story.find_by_slug(params[:story_id])
    @post  = @story.posts.find_by_slug(params[:id])

    if @post.destroy
      redirect_to story_url(@story), notice: 'Post was successfully deleted'
    else
      redirect_to @post, notice: 'Sorry, something went wrong. Try again.'
    end
  end
end
