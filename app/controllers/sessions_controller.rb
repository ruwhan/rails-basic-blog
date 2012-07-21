class SessionsController < ApplicationController
  def new
    render :action => 'new'
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end
end
