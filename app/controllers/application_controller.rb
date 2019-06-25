class ApplicationController < ActionController::Base

  private

  def require_current_user
    unless current_user
      redirect_to login_path, notice: 'Login required'
      return false
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
end
