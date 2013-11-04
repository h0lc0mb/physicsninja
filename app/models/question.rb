class Question < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :responses, dependent: :destroy

  validates :content, presence: true, length: { maximum: 2500 }
  validates :user_id, presence: true

  default_scope order: 'questions.created_at DESC'

  def response_feed
  	Response.where("question_id = ?", id)
  end
end