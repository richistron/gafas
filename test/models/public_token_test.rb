require "test_helper"

class PublicTokenTest < ActiveSupport::TestCase
  test "the truth" do
    public_token = PublicToken.create!
    assert_equal public_token.valid?, true
  end
end
