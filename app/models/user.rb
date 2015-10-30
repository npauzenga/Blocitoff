class User < ActiveRecord::Base
  attr_accessor :password, :reset_token
  before_save :encrypt_password
  before_create :confirmation_token

  validates :password, confirmation: true
  validates :password, :email, presence: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  }
  validates :email, uniqueness: true

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

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def self.digest(string)
    salt = BCrypt::Engine.generate_salt
    BCrypt::Engine.hash_secret(string, salt)
  end

  def self.new_token
    SecureRandom.urlsafe_base64.to_s
  end

  def confirmation_token
    return unless self.confirm_token.blank?
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
