class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, length: { minimum: 5 },  on: :update
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }

  before_create :populate_initial_username

  private

  def populate_initial_username
    self.username = self.email.to_s.split('@')[0]
  end
end
