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

  describe '#reset_password!' do
    it 'generates a 40 digit reset password token expires 6 hours later' do
      user.reset_password!
      expect(user.reset_password_token.length).to eq(40)
      expect(user.reset_password_token_expired_at).to be_within(6.hours).of(Time.now)
    end
  end

  describe '#reset_password_token_expired?' do
    it 'returns true if time has passed reset_password_token_expired_at' do
      user.update(reset_password_token_expired_at: 1.hours.ago)
      expect(user).to be_reset_password_token_expired
    end

    it 'returns false if time hasn\'t passed reset_password_token_expired_at' do
      user.update(reset_password_token_expired_at: 1.hours.from_now)
      expect(user).to_not be_reset_password_token_expired
    end
  end
end