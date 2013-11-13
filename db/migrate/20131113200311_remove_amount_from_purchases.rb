class RemoveAmountFromPurchases < ActiveRecord::Migration
  def up
    remove_column :purchases, :amount
  end

  def down
    add_column :purchases, :amount, :float
  end
end
