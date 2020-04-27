class CategoryTransaction < ApplicationRecord
  belongs_to :category
  # :transaction_ is used instead of :transaction as it conflicts with
  # a method already defined by Active Record.
  belongs_to :transaction_, class_name: 'Transaction', foreign_key: :transaction_id,
                            inverse_of: :categories_transactions
end
