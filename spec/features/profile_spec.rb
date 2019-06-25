require 'rails_helper'

RSpec.describe 'User profile' do
  let(:email_prefix) { 'someone' }
  let!(:user) { create(:user, email: "#{email_prefix}@example.com") }

  before do
    login_with(user.email, user.password)
  end

  context 'page information' do
    it 'profile page' do
      expect(page).to have_content('Profile')
    end

    it 'shows signup email prefix as username' do
      expect(find_field('Username').value).to eq(email_prefix)
    end

    it 'disables email field from input' do
      expect(page).to have_css('#user_email[disabled]')
    end

    it 'shows password fields for input' do
      expect(find_field('Password').value).to be_blank
      expect(find_field('Password confirmation').value).to be_blank
    end
  end

  context 'update username' do
    it 'succeeds if input has more than 5 characters' do
      fill_in 'Username', with: 'Mason'
      click_button 'Update'
      expect(find_field('Username').value).to eq('Mason')
    end

    it 'fails if input has less than 4 characters' do
      fill_in 'Username', with: 'Four'
      click_button 'Update'
      expect(page).to have_content('Username is too short (minimum is 5 characters)')
    end
  end

  context 'update password' do
    it 'succeeds if password is valid and confirmed' do
      new_password = Faker::Internet.password(8)

      fill_in 'Password', with: new_password, exact: true
      fill_in 'Password confirmation', with: new_password, exact: true
      click_button 'Update'
      expect(user.reload.authenticate(new_password)).to be_truthy
    end
  end
end
