class User < ActiveRecord::Base
  attr_accessor :password

  has_many :todos

  before_save :encrypt_password
  before_create :confirmation_token

  validates :password, confirmation: true
  validates :password, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  }

  def encrypt_password
    return unless password.present?
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def authenticate(password)
    password_input = BCrypt::Engine.hash_secret(password, self.password_salt)
    password_input == self.password_hash
  end

  private

  def confirmation_token
    return unless self.confirm_token.blank?
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
