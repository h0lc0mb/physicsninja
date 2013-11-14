class CreateNinjas < ActiveRecord::Migration
  def change
    create_table :ninjas do |t|
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
