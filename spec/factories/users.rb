FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Passw0rd' }
    password_confirmation { 'Passw0rd' }
  end
end
