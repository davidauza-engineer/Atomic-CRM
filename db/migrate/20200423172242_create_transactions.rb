class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :author_id, null: false
      t.string :name, limit: 255, null: false, default: 'My transaction'
      t.text :description, limit: 1530, null: false, default: ''
      t.decimal :amount, precision: 15, scale: 2, null: false, default: 0.00

      t.timestamps
    end
    add_index :transactions, :author_id
    add_foreign_key :transactions, :users, column: :author_id,
                    primary_key: 'id'
    add_index :transactions, :name
  end
end
