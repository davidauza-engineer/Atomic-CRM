class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, limit: 255, allow_null: false, default: 'My custom category'
      t.string :icon, limit: 255, allow_nul: false, default: 'my_custom_category.svg'

      t.timestamps
    end
  end
end
