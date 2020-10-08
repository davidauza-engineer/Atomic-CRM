FactoryBot.define do
  factory :transaction do
    sequence(:name) { |n| "Transaction #{n}" }
    description { 'My description' }
    amount { 99.99 }
  end
end
