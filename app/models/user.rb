class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

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
end
