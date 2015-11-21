class User < ActiveRecord::Base
  attr_accessor :password, :reset_token, :confirm_token

  has_many :todos

  validates :password, confirmation: true
  validates :password, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  }
end
