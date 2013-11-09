class AddQBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :q_balance, :integer
  end
end
