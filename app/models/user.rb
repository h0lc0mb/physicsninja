class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :q_balance, :stripe_customer_token
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :responses
  has_many :comments
  has_many :purchases
  has_many :ninjas

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
    Question.where("user_id = ? and id not in (?)", id, Question.joins(:responses)).order("questions.created_at DESC")
  end

  def answered
    Question.joins(:responses).where("questions.user_id = ?", id).order("questions.created_at DESC")
  end

  def responded
    Question.joins(:responses).where("responses.user_id = ?", id).order("responses.created_at DESC")
  end

  def new_comment
    Question.last_comments.joins(:responses)
      .where("responses.user_id = ? and comments.user_id != ?", id, id)
      .group("questions.id")
      .order("comments.created_at ASC")
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end 