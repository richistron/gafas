class AuthController < ApplicationController
  before_action :validate_public_token, only: :sign_in
  before_action :validate_user_token, only: :me

  def sign_in
    user = User.create! sign_in_params
    user_token = UserToken.create! user: user
    render json: { access_token: user_token.token }, status: :created
  rescue StandardError
    render json: user.errors, status: :unprocessable_entity
  end

  def me
    render json: {
             user: {
               email: @session[:user].email,
               id: @session[:user].id,
               access_token: @session[:token]
             }
           },
           status: :ok
  end

  private

  def sign_in_params
    params.permit(:email, :password, :password_confirmation)
  end
end
