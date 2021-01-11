class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def validate_public_token
    authenticate_or_request_with_http_token do |token|
      public = PublicToken.find_by token: token
      is_valid = is_token_valid public
      public.try(:destroy) unless is_valid

      is_valid
    end
  end

  def validate_user_token
    authenticate_or_request_with_http_token do |token|
      user_token = UserToken.find_by token: token
      @user_token = user_token
      is_token_valid(@user_token) { @user_token.destroy }
    end
  end

  def is_token_valid(user_token)
    return false if user_token.nil?

    expires = DateTime.parse user_token.expires.to_s
    now = DateTime.now
    is_valid = expires > now
    yield if block_given? && !is_valid

    is_valid
  end
end
