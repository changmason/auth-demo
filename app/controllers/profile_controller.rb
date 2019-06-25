class ProfileController < ApplicationController
  before_action :require_current_user

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    flash.now[:notice] = 'Profile or password updated'
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
