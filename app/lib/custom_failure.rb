class CustomFailure < Devise::FailureApp
  def respond
    http_auth
  end
  def http_auth_body
    {error: 'unconfirmed_email'}.to_json
  end
end
