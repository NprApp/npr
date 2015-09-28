class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!

  def new
    render json: {}
  end

  def create
    self.resource = warden.authenticate(auth_options)
    unless self.resource.present?
      render json: {error: 'wrong_user_or_password'}, status: 401
      return
    end

    sign_in(resource_name, resource)
    render json: {
          id: resource.id,
          user_email: resource.email,
          user_token: resource.authentication_token,
          user_admin: resource.is_admin
        }, status: 201
  end

end
