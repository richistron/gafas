class AuthController < ApplicationController
  before_action :validate_public_token, only: %i[sign_in login]
  before_action :validate_user_token, only: :me

  def sign_in
    user = User.create! sign_in_params
    user_token = UserToken.create! user: user
    render json:
             user_response(
               email: user_token.user.email,
               id: user_token.user.id,
               token: user_token.token
             ),
           status: :created
  rescue StandardError
    render json: user.errors, status: :unprocessable_entity
  end

  def me
    render json:
             user_response(
               email: @user_token.user.email,
               id: @user_token.user.id,
               token: @user_token.token
             ),
           status: :ok
  end

  def login
    if valid_user?
      render status: :ok,
             json:
               user_response(
                 email: login_user.email,
                 id: login_user.id,
                 token: login_user.user_token.token
               )
    else
      render status: :unauthorized
    end
  end

  private

  def user_response(email:, id:, token:)
    { user: { email: email, id: id, access_token: token } }
  end

  def sign_in_params
    params.permit(:email, :password, :password_confirmation)
  end

  def valid_user?
    login_user.authenticate login_params[:password]
  rescue StandardError
    false
  end

  def login_params
    params.permit(:email, :password)
  end

  def login_user
    User.find_by email: login_params[:email]
  end
end
