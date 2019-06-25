class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:login][:email])
    if user.try(:authenticate, params[:login][:password])
      session[:current_user_id] = user.id
      redirect_to profile_path, notice: 'Logged in successfully'
    else
      flash.now[:notice] = 'Incorrect email or password'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path, notice: 'Logged out successfully'
  end
end
