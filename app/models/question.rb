class Question < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 2500 }
  validates :user_id, presence: true

  #default_scope order: 'questions.created_at DESC'

  scope :last_comments, lambda {
        joins(:comments).where("comments.created_at in 
                                (SELECT create_time FROM
                                (SELECT question_id, MAX(created_at) create_time FROM comments GROUP BY question_id) t1)")
                        .group("comments.question_id, questions.created_at")
      }

  def response_feed
  	Response.where("question_id = ?", id)
  end

  def comment_feed
    Comment.where("question_id = ?", id)
  end
end