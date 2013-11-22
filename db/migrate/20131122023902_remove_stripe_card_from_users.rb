class RemoveStripeCardFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :stripe_card_token
  end

  def down
    add_column :users, :stripe_card_token, :string
  end
end
