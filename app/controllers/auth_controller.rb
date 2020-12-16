class AuthController < ApplicationController
  def sign_in
    user = User.new sign_in_params
    user.save!
    render status: :created
  rescue
    render json: user.errors, status: :unprocessable_entity
  end

  private

  def sign_in_params
    params.permit(:email, :password, :password_confirmation)
  end
end
