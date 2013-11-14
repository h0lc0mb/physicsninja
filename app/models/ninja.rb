class Ninja < ActiveRecord::Base
  attr_accessible :email, :user_id
  belongs_to :users

end