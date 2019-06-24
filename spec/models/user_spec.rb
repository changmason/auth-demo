require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  it { should have_secure_password }

  context 'validations' do
    it { should validate_presence_of(:username).on(:update) }
    it { should validate_length_of(:username).is_at_least(5).on(:update) }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_length_of(:password).is_at_least(8) }

    it 'should validate format of email' do
      user.email = 'invalid@email_address'
      expect(user).not_to be_valid
      expect(user.errors[:email]).to eq(['is invalid'])
    end
  end

  context 'successful creation' do
    it 'populates initial username with prefix of email' do
      expect(user.username).to eq(user.email.split('@').first)
    end
  end
end