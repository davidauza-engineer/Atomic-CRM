FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:icon) { |n| "#{n}.svg" }
  end
end
