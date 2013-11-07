class Comment < ActiveRecord::Base
  attr_accessible :content, :question_id, :user_id
  belongs_to :question
  belongs_to :user

  validates :content, presence: true, length: { maximum: 2500 }
  validates :question_id, presence: true
  validates :user_id, presence: true
end