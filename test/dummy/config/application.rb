require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "spina"

module Dummy
  class Application < Rails::Application
    config.load_defaults 7.0

    config.hosts << "dummy.puma"
    config.hosts << "dummy.test"
    
    overrides = "#{Rails.root}/app/overrides"
    Rails.autoloaders.main.ignore(overrides)
    config.to_prepare do
      Dir.glob("#{overrides}/**/*_override.rb").each do |override|
        load override
      end
    end
  end
end
