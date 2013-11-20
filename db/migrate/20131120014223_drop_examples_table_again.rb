class DropExamplesTableAgain < ActiveRecord::Migration
  def up
  	drop_table :examples
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
