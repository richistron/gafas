require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test 'should get sign_in' do
    get sign_in_url,
        headers: { 'Authorization' => 'Token 123' },
        params: { email: 'new_user@gmail.com', password: '123', password_confirmation: '123' }
    assert_response :success
  end
end
