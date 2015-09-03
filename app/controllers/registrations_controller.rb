class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!

  def create
    build_resource(sign_up_params)
    if resource.valid?
      resource.save
      yield resource if block_given?
      if resource.persisted?
        render json: {success: 'wait_for_confirmation'}, status: 200
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      render json: { errors: resource.errors }, status: 500
    end
  end
end
