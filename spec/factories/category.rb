FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:icon) { 'my_custom_category.svg' }
  end
end
