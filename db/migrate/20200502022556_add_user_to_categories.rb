class AddUserToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :user_id, :bigint
    add_index :categories, :user_id
    add_foreign_key :categories, :users
  end
end
