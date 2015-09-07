class User < Sequel::Model
  plugin :devise
  devise :database_authenticatable, :timeoutable, :trackable, :registerable, :confirmable, :validatable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if email = conditions.delete(:email)
      demail = email.downcase
      where(conditions).where(Sequel.function(:lower, :email) => demail).first
    else
      where(conditions).first
    end
  end

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update(params)
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end


end
