class User < ApplicationRecord
  has_secure_password
  has_one :user_token

  validates_uniqueness_of :email
  validates_presence_of :email
end
