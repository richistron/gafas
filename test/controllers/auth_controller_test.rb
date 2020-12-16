require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test 'should get sign_in' do
    post sign_in_url,
         headers: { 'Authorization' => 'Token 123' },
         params: { email: 'new_user@gmail.com', password: '123', password_confirmation: '123' }
    assert_response :success
  end

  test 'invalid token sign_in' do
    post sign_in_url,
         headers: { 'Authorization' => 'Token nope' },
         params: { email: 'new_user@gmail.com', password: '123', password_confirmation: '123' }
    assert_response :unauthorized
  end

  test 'should get me' do
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
