class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def validate_public_token
    authenticate_or_request_with_http_token do |token|
      begin
        public = PublicToken.find_by token: token
        expires = DateTime.parse public.expires.to_s
        now = DateTime.now
        expires > now
      rescue StandardError
        false
      end
    end
  end

  def validate_user_token
    authenticate_or_request_with_http_token do |token|
      user_token = UserToken.find_by token: token
      @user_token = user_token
      @user_token.try(:token)
    rescue StandardError
      false
    end
  end
end
