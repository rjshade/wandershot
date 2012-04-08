class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show,:popular]

  def index
    @stories = Story.latest.limit(3)
  end

  def show
    @story = Story.find_by_slug(params[:id])
    if @story
      @posts = @story.posts.latest
      @comments = @story.comments.latest
    else
      redirect_to stories_path, notice: "No story with the title #{params[:id].humanize.titleize}!"
    end
  end

  def new
    @story = current_user.stories.new
  end

  def edit
    @story = current_user.stories.find_by_slug(params[:id])
  end

  def create
    @story = current_user.stories.build(params[:story])

    if @story.save
      redirect_to @story, notice: 'Story was successfully created. Click "Add Post" to get started...'
    else
      render action: "new"
    end
  end

  def update
    @story = current_user.stories.find_by_slug(params[:id])

    if @story.update_attributes(params[:story])
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @story = current_user.stories.find_by_slug(params[:id])
    if @story.destroy
      redirect_to stories_url, notice: "Your story has been permanently deleted"
    else
      redirect_to @story, notice: "Sorry, something went wrong. Try again."
    end
  end

  def popular
    @stories = Story.with_images
  end
end
