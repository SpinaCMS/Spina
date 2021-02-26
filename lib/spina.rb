require 'spina/engine'
require 'spina/railtie'
require 'spina/plugin'
require 'spina/theme'
require 'spina/attr_json_spina_parts_model'

module Spina

  include ActiveSupport::Configurable

  PARTS = []
  PLUGINS = []
  THEMES = []

  config_accessor :backend_path, 
                  :frontend_parent_controller,
                  :disable_frontend_routes,
                  :max_page_depth, 
                  :locales, 
                  :embedded_image_size

  # Specify a backend path. Defaults to /admin.
  self.backend_path = 'admin'
  
  # The parent controller all frontend Spina controllers inherit from
  # Default is ApplicationController
  self.frontend_parent_controller = "ApplicationController"

  self.disable_frontend_routes = false

  self.max_page_depth = 5

  self.locales = [I18n.default_locale]

  # Images that are embedded in the Trix editor are resized to fit
  # You can optimize this for your website and go for a smaller (or larger) size
  # Default: 2000x2000px
  self.embedded_image_size = "2000x2000>"

end
