require 'test_helper'

class PublicTokenTest < ActiveSupport::TestCase
  test 'smoke test' do
    public_token = PublicToken.create!
    assert_equal public_token.valid?, true
  end
end
