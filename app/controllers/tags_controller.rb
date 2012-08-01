class TagsController < ApplicationController
  def index
    term = params[:term]
    @tags = Tag.find(:all, :select => :name, :conditions => "name LIKE '%#{term}%'").map(&:name)
    
    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end
