class Comment < ActiveRecord::Base
  attr_accessible :content, :question_id, :user_id
  belongs_to :question
  belongs_to :user

  validates :content, presence: true, length: { maximum: 2500 }
  validates :question_id, presence: true
  validates :user_id, presence: true

  scope :last_comments, 
        conditions: 
            "comments.created_at in 
            	(SELECT create_time FROM
            		(SELECT question_id, MAX(created_at) create_time FROM comments GROUP BY question_id))",
        group: "comments.question_id"
end