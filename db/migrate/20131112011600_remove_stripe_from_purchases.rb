class RemoveStripeFromPurchases < ActiveRecord::Migration
  def up
    remove_column :purchases, :stripe_customer_token
  end

  def down
    add_column :purchases, :stripe_customer_token, :string
  end
end
