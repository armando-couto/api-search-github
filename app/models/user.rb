class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password, length: {minimum: 6}, if: -> {new_record? || !password.nil?}
  validates :oauth_token, presence: true, uniqueness: true

  validates_presence_of :name, :password_digest, :oauth_token
end
