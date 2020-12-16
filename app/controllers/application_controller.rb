class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def validate_public_token
    authenticate_or_request_with_http_token do |token|
      public = PublicToken.find_by token: token
      if is_token_valid public
        true
      else
        public.try(:destroy)
        false
      end
    end
  end

  def validate_user_token
    authenticate_or_request_with_http_token do |token|
      user_token = UserToken.find_by token: token
      @user_token = user_token
      if is_token_valid user_token
        true
      else
        user_token.try(:destroy)
        false
      end
    end
  end

  def is_token_valid(user_token)
    return false if user_token.nil?

    expires = DateTime.parse user_token.expires.to_s
    now = DateTime.now

    expires > now
  end
end
