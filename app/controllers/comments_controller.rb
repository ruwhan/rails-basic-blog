class CommentsController < ApplicationController
  before_filter :authenticate, :only => :destroy
  
  def new
    @post = Post.find(params[:post_id])
    @comments = @post.comments.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post, :notice => 'thanks for your comment' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, :alert => 'unable to add comment' }
        format.js { render 'fail_create.js.erb' }
      end
    end
    
    #redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to post_path(@post)
  end
end
