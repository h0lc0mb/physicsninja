class RemoveStripeCustomerFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :stripe_customer_token
  end

  def down
    add_column :users, :stripe_customer_token, :string
  end
end
