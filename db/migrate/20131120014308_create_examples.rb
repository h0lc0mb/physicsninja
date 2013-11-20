class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.integer :id
      t.string :question
      t.string :response

      t.timestamps
    end
  end
end
