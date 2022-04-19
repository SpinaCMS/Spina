require 'spina/engine'
require 'spina/admin_sectionable'
require 'spina/railtie'
require 'spina/theme_reloader'
require 'spina/plugin'
require 'spina/theme'
require 'spina/attr_json_spina_parts_model'
require 'spina/attr_json_monkeypatch'
require 'spina/authentication/sessions'
require 'spina/authentication/basic'
require 'spina/embeddable'
require 'spina/embeds'
require 'spina/embeds/trix_conversion'

module Spina
  include ActiveSupport::Configurable

  PARTS = []
  PLUGINS = []
  THEMES = []

  config_accessor :api_key,
                  :api_path,
                  :authentication,
                  :backend_path, 
                  :importmap,
                  :frontend_parent_controller,
                  :disable_frontend_routes,
                  :disable_decorator_load,
                  :locales, 
                  :embedded_image_size,
                  :mailer_defaults,
                  :thumbnail_image_size,
                  :party_pooper,
                  :tailwind_content,
                  :queues,
                  :transliterations

  # Defaults
  self.api_key = nil
  self.api_path = "api"
  self.authentication = "Spina::Authentication::Sessions"
  self.backend_path = 'admin'
  self.disable_frontend_routes = false
  self.disable_decorator_load = false
  self.embedded_image_size = [2000, 2000]
  self.mailer_defaults = ActiveSupport::OrderedOptions.new
  self.thumbnail_image_size = [400, 400]
  self.frontend_parent_controller = "ApplicationController"
  self.locales = []
  self.party_pooper = false
  self.transliterations = %i(latin)
  
  # Queues for background jobs
  # - config.queues.page_updates
  self.queues = ActiveSupport::InheritableOptions.new
  
  # An importmap specifically meant for Spina
  self.importmap = Importmap::Map.new
    
  # Tailwind content
  # In order for Tailwind to generate all of the CSS Spina needs, 
  # it needs to know about every single file in your project 
  # that contains any Tailwind class names.
  # Make sure to add your own glob patterns if you're extending
  # Spina's UI.
  self.tailwind_content = ["#{Spina::Engine.root}/app/views/**/*.*",
                           "#{Spina::Engine.root}/app/components/**/*.*",
                           "#{Spina::Engine.root}/app/helpers/**/*.*",
                           "#{Spina::Engine.root}/app/assets/javascripts/**/*.js",
                           "#{Spina::Engine.root}/app/**/application.tailwind.css"]

  # Images that are embedded in the Trix editor are resized to fit
  # You can optimize this for your website and go for a smaller (or larger) size
  # Default: 2000x2000px
  class << self
    alias_method :config_original, :config
    
    def config
      config_obj = self.config_original
      
      def config_obj.tailwind_purge_content
        ActiveSupport::Deprecation.warn("config.tailwind_purge_content has been renamed to config.tailwind_content")
        tailwind_content
      end
      
      def config_obj.tailwind_purge_content=(paths)
        ActiveSupport::Deprecation.warn("config.tailwind_purge_content has been renamed to config.tailwind_content")
        tailwind_content = paths
      end
      
      def config_obj.embedded_image_size=(image_size)
        if image_size.is_a? String
          ActiveSupport::Deprecation.warn("Spina embedded_image_size should be set to an array of arguments to be passed to the :resize_to_limit ImageProcessing macro. https://github.com/janko/image_processing/blob/master/doc/minimagick.md#resize_to_limit")
        end
        
        self[:embedded_image_size] = image_size
      end
      
      config_obj
    end
    
    def locales
      config.locales.presence || [I18n.default_locale]
    end
    
    def mounted_at
      Spina::Engine.routes.find_script_name({})
    end
    
  end
end
