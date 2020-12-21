require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test 'me' do
    post me_url, headers: { 'Authorization' => 'Token 123token' }
    assert_response :success
  end

  test 'me invalid token' do
    post me_url, headers: { 'Authorization' => 'Token nope' }
    assert_response :unauthorized
  end

  test 'login' do
    user = User.create! email: 'test@mail.com', password: '123'
    user_token = UserToken.create! user: user
    post login_url,
         headers: { 'Authorization' => 'Token 123' },
         params: { email: user.email, password: '123' }
    assert_response :success
    assert user_token.token
    json_response = JSON.parse response.body
    assert_equal user_token.token, json_response['user']['access_token']
  end
end
