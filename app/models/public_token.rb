class PublicToken < ApplicationRecord
  has_secure_token
  before_save :set_expiration_date

  private

  def set_expiration_date
    self.expires = DateTime.now.next_month 1
  end
end
