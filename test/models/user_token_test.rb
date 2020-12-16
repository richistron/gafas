require 'test_helper'

class UserTokenTest < ActiveSupport::TestCase
  test 'token expires in 1 month' do
    user = User.first
    user_token = UserToken.create! user: user
    expire_time = DateTime.parse user_token.expires.to_s
    assert expire_time < DateTime.now.next_day(2)
  end
end
