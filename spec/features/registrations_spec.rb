require 'rails_helper'

RSpec.describe 'User sign-up' do
  let!(:user) { create(:user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(8) }
  let(:short_password) { Faker::Internet.password(1, 7) }

  before do
    visit '/sign_up'
  end

  context 'with correct info' do
    it 'succeeds and redirects user to profile page' do
      expect(page).to have_content('Sign up')
      sign_up_with(email, password, password)
      expect(page).to have_content('Profile')
    end

    it 'sends out welcome email immediately' do
      expect(UserMailer).to receive_message_chain(:welcome, :deliver_now)
      sign_up_with(email, password, password)
    end
  end

  context 'form validations' do
    it 'fails and shows errors about email field' do
      sign_up_with('', password, password)
      expect(page).to have_content('Email can\'t be blank')

      sign_up_with('wrong-email', password, password)
      expect(page).to have_content('Email is invalid')

      sign_up_with(user.email, password, password)
      expect(page).to have_content('Email has already been taken')
    end

    it 'fails and shows errors about password fields' do
      sign_up_with(email, '', '')
      expect(page).to have_content('Password can\'t be blank')

      sign_up_with(email, password, password + 'oops')
      expect(page).to have_content('Password confirmation doesn\'t match Password')

      sign_up_with(email, short_password, short_password)
      expect(page).to have_content('Password is too short (minimum is 8 characters)')
    end
  end
end
