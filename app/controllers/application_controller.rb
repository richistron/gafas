class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :validate_token

  private

  def validate_token
    authenticate_or_request_with_http_token do |token|
      begin
        public = PublicToken.find_by token: token
        expires = DateTime.parse public.expires.to_s
        now = DateTime.now
        expires > now
      rescue
        false
      end
    end
  end
end
