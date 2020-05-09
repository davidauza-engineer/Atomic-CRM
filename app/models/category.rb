class Category < ApplicationRecord
  has_many :categories_transactions, dependent: :destroy
  # :transaction_s is used instead of :transactions as transaction conflicts with
  # a method already defined by Active Record.
  has_many :transaction_s, through: :categories_transactions, class_name: 'Transaction',
                           foreign_key: :id
  # TODO: finish associations and corresponding tests

  belongs_to :user

  default_scope { order(created_at: :asc) }
end
