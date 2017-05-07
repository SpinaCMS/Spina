Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  # ActionMailer Config

  config.action_mailer.default_url_options = { host: 'dummy.dev' }

  # change to false to prevent email from being sent during development
  config.action_mailer.perform_deliveries = true

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener
end
