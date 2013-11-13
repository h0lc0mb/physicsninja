class AddAmountToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :amount, :float
  end
end
