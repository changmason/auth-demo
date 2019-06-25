class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, length: { minimum: 5 },  on: :update
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, length: { minimum: 8 }, unless: -> { password.blank? }

  before_create :populate_initial_username

  private

  def populate_initial_username
    self.username = self.email.to_s.split('@')[0]
  end
end
