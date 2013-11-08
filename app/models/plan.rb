class Plan < ActiveRecord::Base
	attr_accessible :name, :price, :questions
  has_many :purchases
end
