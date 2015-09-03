require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "action_mailer/railtie"
require "action_controller/railtie"
require "pry"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Npr
  class Application < Rails::Application
    config.sequel.schema_dump = true
    config.sequel.schema_format = :sql
    config.middleware.use ActionDispatch::Flash
  end
end
