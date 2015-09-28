class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_filter :authenticate_user!

  def authenticate_user!
    user = User.where(email: request.env["HTTP_X_USER_EMAIL"], authentication_token: request.env["HTTP_X_USER_TOKEN"]).first
    if user.present?
      sign_in user, store: false
    else
      render json: {error: :unauthorized}, status: 401
    end
  end

end
