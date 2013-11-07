class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
    add_index :comments, [:question_id, :created_at]
  end
end
