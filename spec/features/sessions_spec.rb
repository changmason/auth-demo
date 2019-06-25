require 'rails_helper'

RSpec.describe 'User sessions' do
  let!(:user) { create(:user) }

  before do
    visit '/login'
  end

  context 'login' do
    context 'correct username and password' do
      it 'succeeds and redirects user to profile page' do
        expect(page).to have_content('Login')
        login_with(user.email, user.password)
        expect(page).to have_content('Profile')
        expect(page).to have_content('Logged in successfully')
      end
    end

    context 'wrong username and password' do
      it 'stays on login page and shows notice message' do
        expect(page).to have_content('Login')
        login_with(user.email, 'wrong password')
        expect(page).to have_content('Login')
        expect(page).to have_content('Incorrect email or password')
      end
    end
  end
end
