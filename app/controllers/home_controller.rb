class HomeController < ApplicationController
  def index
    @posts = Post.page(params[:page]).order('created_at DESC, published_date DESC').where('published_date IS NOT NULL')
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
