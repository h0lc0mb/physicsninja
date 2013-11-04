class Response < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :question

  validates :content, presence: :true, length: { maximum: 2500 }
  validates :user_id, presence: true
  validates :question_id, presence: :true
end