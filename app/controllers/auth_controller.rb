class AuthController < ApplicationController
  before_action :validate_public_token, only: %i[sign_in login]
  before_action :validate_user_token, only: %i[logout me]

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
    user = User.find_by email: login_params[:email]
    if user && valid_user_session?(user)
      create_user_token user
      render status: :ok,
             json: user_response(email: user.email, id: user.id, token: user.user_token.token)
    else
      render status: :unauthorized
    end
  end

  def sup
    last_token = PublicToken.last
    render json: { access_token: last_token.token }, status: :ok
  end

  def logout
    @user_token.try(:destroy)
    render status: :ok, json: { message: 'session destroyed' }
  end

  private

  def login_params
    params.permit :email, :password
  end

  def user_response(email:, id:, token:)
    { user: { email: email, id: id, access_token: token } }
  end

  def valid_user_session?(user)
    user.authenticate login_params[:password]
  rescue StandardError
    false
  end

  def create_user_token(user)
    UserToken.create! user: user unless user.user_token
  end
end
