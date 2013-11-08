class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :purchases, :plan, :plan_id
  end
end
