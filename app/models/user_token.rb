class UserToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  validates_presence_of :user_id
  before_save :set_expiration

  private

  def set_expiration
    self.expires = DateTime.now.next_day 1
  end
end
