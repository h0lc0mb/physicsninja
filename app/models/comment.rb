class Comment < ActiveRecord::Base
  attr_accessible :content, :question_id, :user_id
  belongs_to :question
  belongs_to :user

  validates :content, presence: true, length: { maximum: 2500 }
  validates :question_id, presence: true
  validates :user_id, presence: true

  scope :last_comments, -> { where('created_at = (SELECT MAX(created_at) FROM comments GROUP BY question_id') }
end