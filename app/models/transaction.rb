class Transaction < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
  validates :description, length: { maximum: 1530 }
  AMOUNT_FORMAT_REGEX = /\A\d+(?:\.\d{0,2})?\z/
  validates :amount, format: { with: AMOUNT_FORMAT_REGEX }
end
