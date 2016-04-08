require 'spina/engine'
require 'spina/template'

module Spina

  include ActiveSupport::Configurable

  PLUGINS = []
  THEMES = []

  config_accessor :backend_path, :storage, :max_page_depth

  self.backend_path = 'admin'

  self.storage = :file

  self.max_page_depth = 5

  class << self

    def register_theme(deprecated_theme)
      Spina::Theme.register do |theme|
        theme.name            = deprecated_theme.name
        theme.title           = deprecated_theme.config.title
        theme.page_parts      = deprecated_theme.config.page_parts
        theme.view_templates  = deprecated_theme.config.view_templates
        theme.layout_parts    = deprecated_theme.config.layout_parts
        theme.custom_pages    = deprecated_theme.config.custom_pages
        theme.plugins         = deprecated_theme.config.plugins
        theme.structures      = deprecated_theme.config.structures
        theme.public_theme    = deprecated_theme.config.public_theme
      end
    end

  end
end
