class PasswordController < ApplicationController
  before_action :find_token_user, only: [:new, :create]

  def forget
  end

  def reset
    if user = User.find_by(email: params[:user][:email])
      user.reset_password!
      UserMailer.reset_password(user).deliver_now
      redirect_to forget_password_path, notice: 'Reset password instruction sent'
    else
      redirect_to forget_password_path, notice: 'Email user not found'
    end
  end

  def new
    flash.now[:notice] = 'Your token is invalid or expired' unless @user
  end

  def create
    if @user
      if @user.update(user_params) && @user.clear_reset_password_token!
        redirect_to login_path, notice: 'New password is set successfully'
      else
        render :new
      end
    else
      redirect_to new_password_path
    end
  end

  private

  def find_token_user
    return false if params[:token].blank?

    @user = User.find_by(reset_password_token: params[:token])
    @user = nil if @user && @user.reset_password_token_expired?
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end