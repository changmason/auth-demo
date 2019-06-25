require 'rails_helper'

RSpec.describe 'User sessions' do
  let!(:user) { create(:user) }

  context 'login' do
    context 'correct username and password' do
      it 'succeeds and redirects user to profile page' do
        login_with(user.email, user.password)
        expect(page).to have_content('Profile')
        expect(page).to have_content('Logged in successfully')
      end
    end

    context 'wrong username and password' do
      it 'stays on login page and shows notice message' do
        login_with(user.email, 'wrong password')
        expect(page).to have_content('Login')
        expect(page).to have_content('Incorrect email or password')
      end
    end
  end

  context 'logout' do
    it 'redirects the user to login page' do
      login_with(user.email, user.password)
      visit logout_path
      expect(page).to have_content('Login')
      expect(page).to have_content('Logged out successfully')
    end
  end
end
