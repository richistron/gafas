class AuthController < ApplicationController
  before_action :validate_public_token, only: %i[sign_in login]
  before_action :validate_user_token, only: :me

  def sign_in
    user = User.new sign_in_params
    if user.valid?
      user.save!
      user_token = create_user_token user
      render json: user_response(email: user.email, id: user.id, token: user_token.token),
             status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
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
    user = User.find_by email: login_params[:email]
    if user && valid_user_session?(user)
      create_user_token user
      render status: :ok,
             json: user_response(email: user.email, id: user.id, token: user.user_token.token)
    else
      render status: :unauthorized
    end
  end

  private

  def login_params
    params.permit :email, :password
  end

  def user_response(email:, id:, token:)
    { user: { email: email, id: id, access_token: token } }
  end

  def sign_in_params
    params.permit :email, :password, :password_confirmation
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
