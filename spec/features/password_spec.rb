require 'rails_helper'

RSpec.describe 'User password' do
  let!(:user) { create(:user) }

  context 'request forget password instruction' do
    it 'sends reset password email if email is correct' do
      visit forget_password_path

      expect(UserMailer).to receive_message_chain(:reset_password, :deliver_now)

      within('#forget-password-form') do
        fill_in 'Email', with: user.email
        click_button 'Reset'
      end

      expect(page).to have_content('Forget password')
      expect(page).to have_content('Reset password instruction sent')
    end

    it 'shows notice message if email user not found' do
      visit forget_password_path

      within('#forget-password-form') do
        fill_in 'Email', with: Faker::Internet.email
        click_button 'Reset'
      end

      expect(page).to have_content('Forget password')
      expect(page).to have_content('Email user not found')
    end
  end
end
