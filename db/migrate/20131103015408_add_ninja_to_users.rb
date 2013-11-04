class AddNinjaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ninja, :boolean, default: false
  end
end
