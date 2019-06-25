class ProfileController < ApplicationController
  def show
    @user = User.last
  end

  def update
    @user = User.last
    @user.update_attributes(user_params)
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
