require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'unique email' do
    User.create! email: 'unique@mail.com', password: '123', password_confirmation: '123'
    duplicated = User.new email: 'unique@mail.com', password: '123', password_confirmation: '123'
    assert_equal duplicated.valid?, false
  end
end
