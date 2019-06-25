class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:login][:email])
    if user.try(:authenticate, params[:login][:password])
      redirect_to profile_path, notice: 'Logged in successfully'
    else
      flash.now[:notice] = 'Incorrect email or password'
      render :new
    end
  end
end
