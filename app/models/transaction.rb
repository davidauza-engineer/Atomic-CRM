class Transaction < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
  validates :description, length: { maximum: 1530 }, allow_nil: false
  AMOUNT_FORMAT_REGEX = /\A\d+(?:\.\d{0,2})?\z/.freeze
  validates :amount, format: { with: AMOUNT_FORMAT_REGEX }

  belongs_to :user, foreign_key: :author_id, inverse_of: :transactions
end
