class Transaction < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
  validates :description, length: { maximum: 1530 }, allow_nil: false
  AMOUNT_FORMAT_REGEX = /\A-?\d+(?:\.\d{0,2})?\z/.freeze
  validates :amount, format: { with: AMOUNT_FORMAT_REGEX }, numericality: true

  belongs_to :user, foreign_key: :author_id, inverse_of: :transactions
  has_many :categories_transactions, dependent: :destroy, foreign_key: :transaction_id,
                                     inverse_of: :transaction_
  accepts_nested_attributes_for :categories_transactions
  has_many :categories, through: :categories_transactions
  # TODO: finish associations and corresponding tests

  scope :newest_first, -> { order(created_at: :desc) }
  scope :oldest_first, -> { order(created_at: :asc) }
end
