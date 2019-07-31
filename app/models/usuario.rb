class Usuario < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, length: {minimum: 6}, if: -> {new_record? || !password.nil?}

  validates_presence_of :nome, :email, :password_digest
end
