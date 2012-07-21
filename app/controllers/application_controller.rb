class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  # Make current_user available in templates as helper
  helper_method :current_user
  
  def authenticate
    logged_in? ? true : deny_access
  end
  
  def logged_in?
    current_user.is_a? User
  end
  
  helper_method :logged_in?
  
  def deny_access
    redirect_to login_path, :notice => 'Please log in to continue' and return false
  end
end
