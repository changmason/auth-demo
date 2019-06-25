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

  context 'set new password' do
    before { user.reset_password! }

    it 'warns the user if token is invalid or expired' do
      visit new_password_path(token: SecureRandom.hex(20))
      expect(page).to have_content('Your token is invalid or expired')

      user.update(reset_password_token_expired_at: 1.hours.ago)
      visit new_password_path(token: user.reset_password_token)
      expect(page).to have_content('Your token is invalid or expired')
    end

    context 'token is valid' do
      it 'succeeds if new password is valid and confirmed' do
        visit new_password_path(token: user.reset_password_token)

        new_password = Faker::Internet.password(8)

        within('#new-password-form') do
          fill_in 'Password', with: new_password, exact: true
          fill_in 'Password confirmation', with: new_password, exact: true
          click_button 'Set Password'
        end

        expect(page).to have_content('Login')
        expect(page).to have_content('New password is set successfully')
        expect(user.reload.authenticate(new_password)).to be_truthy
      end
    end
  end
end
