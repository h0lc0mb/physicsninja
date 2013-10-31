class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  NO_SPACES_REGEX = /^[\S]+$/
  validates :username, presence: true, length: { maximum: 50 }, 
  																 format: { with: NO_SPACES_REGEX, 
  																					 message: "username can't contain spaces" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end 