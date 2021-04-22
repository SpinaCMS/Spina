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
  class << self
    alias_method :config_original, :config
    
    def config
      config_obj = self.config_original
      
      def config_obj.embedded_image_size=(image_size)
        if image_size.is_a? String
          ActiveSupport::Deprecation.warn("Spina embedded_image_size should be set to an array of arguments to be passed to the :resize_to_limit ImageProcessing macro. https://github.com/janko/image_processing/blob/master/doc/minimagick.md#resize_to_limit")
        end
        
        self[:embedded_image_size] = image_size
      end
      
      config_obj
    end
  end
  
  self.embedded_image_size = [2000, 2000]

end
