require 'spina/engine'
require 'spina/template'

module Spina

  include ActiveSupport::Configurable

  config_accessor :backend_path, :storage, :max_page_depth

  self.backend_path = 'admin'

  self.storage = :file

  self.max_page_depth = 5

  class << self

    @@themes = []
    @@plugins = []

    def register_theme(theme)
      @@themes << theme
    end

    def theme(theme_name)
      @@themes.find { |theme| theme.name == theme_name }
    end

    def themes
      @@themes
    end

    def register_plugin(plugin)
      @@plugins << plugin
    end

    def plugin(plugin_name)
      @@plugins.find { |plugin| plugin.name == plugin_name }
    end

    def plugins(plugin_type = :all)
      case plugin_type
      when :website_resource
        @@plugins.find_all { |plugin| plugin.config.plugin_type == 'website_resource' }
      else
        @@plugins
      end
    end

  end
end
