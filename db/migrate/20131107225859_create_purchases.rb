class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :plan
      t.integer :user_id

      t.timestamps
    end
    add_index :purchases, [:user_id, :created_at]
  end
end
