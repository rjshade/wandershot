class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @story = Story.find_by_slug(params[:story_id])
    @post = @story.posts.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def new
    @story = current_user.stories.find_by_slug(params[:story_id])
    @post = @story.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def create
    @story = current_user.stories.find_by_slug(params[:story_id])
    @post = @story.posts.build(params[:post])
    @post.image_path = "stock/stock_#{(0..8).to_a.shuffle.first}.jpg"

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@story,@post], notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @story = current_user.stories.find_by_slug(params[:story_id])
    @post = @story.posts.find_by_slug(params[:id])
  end

  def update
    @story = current_user.stories.find_by_slug(params[:story_id])
    @post = @story.posts.find_by_slug(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [@story,@post], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find_by_slug(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
