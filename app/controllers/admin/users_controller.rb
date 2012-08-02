require 'digest'

class Admin::UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.verified = false
    @user.token = Digest::SHA1.hexdigest(@user.email)
    
    if @user.save
      Notifier.send_notification(@user.email, "http://#{request.host}:#{request.port.to_s}/verify/", @user.token).deliver
      redirect_to posts_path, :notice => 'User successfully added.'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      redirect_to posts_path, :notice => 'User successfully updated.'
    else
      render :action => 'edit'
    end
  end
end
