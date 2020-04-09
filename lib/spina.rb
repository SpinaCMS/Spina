require 'spina/engine'
require 'spina/railtie'
require 'spina/plugin'
require 'spina/theme'
require 'spina/parts/line'

module Spina

  include ActiveSupport::Configurable

  PLUGINS = []
  THEMES = []

  config_accessor :backend_path, :disable_frontend_routes, :storage, :max_page_depth, :locales, :parts

  self.backend_path = 'admin'

  self.disable_frontend_routes = false

  self.storage = :file

  self.max_page_depth = 5

  self.locales = [I18n.default_locale]

  self.parts = [
    Parts::Line
  ]

end
