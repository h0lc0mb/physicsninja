class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :q_balance, :stripe_customer_token
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :responses
  has_many :comments
  has_many :purchases
  has_many :ninjas


  #scope :last_questions, joins(:questions)
  #  .where('questions.created_at = (SELECT MAX(questions.created_at) FROM comments WHERE questions.user_id = users.id)')
  #  .group('users.id')

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  NO_SPACES_REGEX = /^[\S]+$/
  validates :username, presence: true, length: { maximum: 50 }, 
  																 format: { with: NO_SPACES_REGEX, 
  																					 message: "username can't contain spaces" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def pending
    Question.where("user_id = ? and id not in (?)", id, Question.joins(:responses))
  end

  def answered
    Question.joins(:responses).where("questions.user_id = ?", id)
  end

  def responded
    Question.joins(:responses).where("responses.user_id = ?", id)
  end

  def new_comment
    if Rails.env.production?
      Question.includes(:responses, :comments).where("responses.user_id = ? and comments.user_id != ? and comments.created_at < ?", id, id, "now() - interval '24 hours'")
    else
      Question.includes(:responses, :comments).where("responses.user_id = ? and comments.user_id != ? and comments.created_at < ?", id, id, "DATE_SUB(CURDATE(), INTERVAL 1 DAY)")
    end

    #Question.includes(:responses).where("responses.user_id = ? and responses.user_id not in (?)", id, Question.last_commenters)
    #Question.joins(:responses, :last_comments).where("responses.user_id = ? and last_comments.user_id != ?", id, id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end 