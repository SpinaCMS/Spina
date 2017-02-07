require 'spina/engine'
require 'spina/plugin'
require 'spina/railtie'
require 'spina/theme'

module Spina

  include ActiveSupport::Configurable

  PLUGINS = []
  THEMES = []

  config_accessor :backend_path, :disable_frontend_routes, :storage, :max_page_depth, :locales

  self.backend_path = 'admin'

  self.disable_frontend_routes = false

  self.storage = :file

  self.max_page_depth = 5

  self.locales = [I18n.default_locale]

  class << self

    def register_theme(deprecated_theme)
      warn "[DEPRECATION] `register_theme` is deprecated. Please use `::Spina::Theme.register` instead."
      Spina::Theme.register do |theme|
        theme.name            = deprecated_theme.name
        theme.title           = deprecated_theme.config.title
        theme.page_parts      = deprecated_theme.config.page_parts
        theme.view_templates  = deprecated_theme.config.view_templates.inject([]) do |a, (k, v)|
          v[:name] = k
          a << v
        end
        theme.layout_parts    = deprecated_theme.config.layout_parts
        theme.custom_pages    = deprecated_theme.config.custom_pages
        theme.plugins         = deprecated_theme.config.plugins
        theme.structures      = deprecated_theme.config.structures.inject([]) do |a, (k, v)|
          a << { name: k, structure_parts: v }
        end
        theme.public_theme    = deprecated_theme.config.public_theme
      end
    end

  end
end
