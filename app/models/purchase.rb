class Purchase < ActiveRecord::Base
	attr_accessible :plan_id, :user_id
  belongs_to :plan

  validates :plan_id, presence: true
  validates :user_id, presence: true
end
