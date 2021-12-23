require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "spina"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.hosts << "dummy.puma"
    config.hosts << "dummy.test"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

