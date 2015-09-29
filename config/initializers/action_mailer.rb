Rails.application.config.action_mailer.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: 587,
  enable_starttls_auto: true,
  user_name: AppConfig.mandrill_username,
  password: AppConfig.mandrill_password,
  authentication: 'login',
  domain: AppConfig.host
} if %w(production beta staging).include? Rails.env
