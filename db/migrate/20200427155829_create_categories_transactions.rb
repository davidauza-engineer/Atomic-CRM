class CreateCategoriesTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_transactions do |t|
      t.references :category, null: false, foreign_key: true, index: true
      t.references :transaction, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
