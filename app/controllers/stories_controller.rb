class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find_by_slug(params[:id])
    if @story.posts.size > 0 
      @posts = @story.posts.by_date.reverse
    else
      @posts = [];
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
      redirect_to @story, notice: 'Story was successfully created. Go ahead and add a Post by clicking "Add Post".'
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
end
