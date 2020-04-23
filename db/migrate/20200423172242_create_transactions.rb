class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :author_id
      t.string :name
      t.text :description
      t.decimal :amount

      t.timestamps
    end
  end
end
