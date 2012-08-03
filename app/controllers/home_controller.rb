class HomeController < ApplicationController
  def index
    @posts = Post.find(:all, :conditions => 'published_date IS NOT NULL')
  end
  
  def show
    @post = Post.find(params[:id])
    
    respond_to do |format|
      if !@post.published_date
        redirect_to root_path, :notice => 'blog post is not available'
      else
        format.html
      end
    end
  end
end
