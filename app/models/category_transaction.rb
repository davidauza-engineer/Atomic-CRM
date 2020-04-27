class CategoryTransaction < ApplicationRecord
  belongs_to :category
  belongs_to :transaction
end
