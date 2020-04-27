class ChangeColumnAtTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :author_id, :bigint
  end
end
