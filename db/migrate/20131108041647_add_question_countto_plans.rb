class AddQuestionCounttoPlans < ActiveRecord::Migration
  def change
  	add_column :plans, :questions, :integer
  end
end
