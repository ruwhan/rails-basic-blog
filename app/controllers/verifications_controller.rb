class VerificationsController < ApplicationController
  def update
    @user = User.find_by_token(params[:token])
    if @user and !@user.verified
      @user.update_password = false
      @user.verified = true
      @user.token = ''
      
      respond_to do |format|
        if @user.save
          format.html { redirect_to login_path, :notice => 'Verification success' }
        else
          format.html { redirect_to login_path, :notice => @user.errors.full_messages }
        end        
      end
      
    end
  end
end
