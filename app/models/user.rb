class User < ApplicationRecord
  has_secure_password

  # validates
  validates :email, presence: true, length: {maximum: 260}, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, uniqueness: {case_sensitive: false}

  # callback
  before_save {self.email = email.downcase}

  # relationships
  has_many :establishments
  belongs_to :address, optional: true

  # login
  def self.login(user, password)
    find_by(email: user, password: password).presence
  end

  def regenerate_token
    update_column(:auth_token, Devise.friendly_token)
  end

  def invalidate_token
    update_column(:auth_token, nil)
  end
end
