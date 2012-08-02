class Admin::PostsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  # GET /posts
  # GET /posts.json
  def index
    if current_user
      @posts = current_user.posts.all
    else
      @posts = Post.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = current_user.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
    
    @tag_names = Tag.find(@post.tag_ids.to_a, :select => :name).map(&:name).to_s.delete('[]"') + ', '
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])
    current_datetime = DateTime.now
    @post.created_at = current_datetime
    @post.last_updated_at = current_datetime
    if params[:post_tags]
      @post.tag_ids = tagging_post(params[:post_tags].split(', '))
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
    current_datetime = DateTime.now
    @post.last_updated_at = current_datetime
    if params[:post_tags]
      @post.tag_ids = tagging_post(params[:post_tags].split(', '))
    end
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  private 
    def tagging_post(tag_names)
      tag_ids = Array.new
      tag_names = tag_names.uniq
      tag_names.each do |name|
        tag = Tag.find_or_create_by_name(name)
        tag_ids << tag.id
      end
      return tag_ids
    end
end
