class Question < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 2500 }
  validates :user_id, presence: true

  default_scope order: 'questions.created_at DESC'

  #scope :last_commenters, joins(:comments)
  #  .where('comments.created_at = (SELECT MAX(comments.created_at) FROM comments WHERE comments.question_id = questions.id)')
  #  .group('questions.id')

  #scope :last_comments, joins(:comments)
  #  .where('comments.created_at = (SELECT MAX(comments.created_at) FROM comments WHERE comments.question_id = questions.id)')
  #  .group('questions.id')

  #scope :last_comments, 
  #      joins: "comments",
  #      conditions: 
  #          "questions.id = comments.question_id and
  #          comments.created_at = (SELECT MAX(created_at) FROM COMMENTS)",
  #      group: "comments.question_id"

  def response_feed
  	Response.where("question_id = ?", id)
  end

  def comment_feed
    Comment.where("question_id = ?", id)
  end
end