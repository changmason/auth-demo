class PasswordController < ApplicationController
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
end