class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]

  def index
    @stories = Story.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

  def show
    @story = Story.find_by_slug(params[:id])
    @posts = @story.posts.by_date.reverse

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
    end
  end

  def new
    @story = current_user.stories.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story }
    end
  end

  def edit
    @story = current_user.stories.find_by_slug(params[:id])
  end

  def create
    @story = current_user.stories.build(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created. Go ahead and add a Post by clicking "Add Post".' }
        format.json { render json: @story, status: :created, location: @story }
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @story = current_user.stories.find_by_slug(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @story = current_user.stories.find_by_slug(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end
end
