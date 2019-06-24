class ProfileController < ApplicationController
  def show
    @user = User.last
  end
end
