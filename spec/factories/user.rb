FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com" }
    password { 'secretsecret' }
    name { 'Test User' }
  end
end
