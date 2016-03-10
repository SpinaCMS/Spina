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

  end
end
