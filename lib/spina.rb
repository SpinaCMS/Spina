require "spina/engine"
require "spina/version"
require "spina/admin_sectionable"
require "spina/railtie"
require "spina/theme_reloader"
require "spina/plugin"
require "spina/theme"
require "spina/attr_json_spina_parts_model"
require "spina/attr_json_monkeypatch"
require "spina/authentication/sessions"
require "spina/authentication/basic"
require "spina/embeddable"
require "spina/embeds"
require "spina/embeds/trix_conversion"

module Spina
  PARTS = []
  PLUGINS = []
  THEMES = []

  mattr_accessor :api_key, default: nil
  mattr_accessor :api_path, default: "api"
  mattr_accessor :authentication, default: "Spina::Authentication::Sessions"
  mattr_accessor :backend_title, default: "Spina CMS"
  mattr_accessor :backend_path, default: "admin"
  mattr_accessor :importmap
  mattr_accessor :frontend_parent_controller, default: "ApplicationController"
  mattr_accessor :disable_frontend_routes, default: false
  mattr_accessor :disable_decorator_load, default: false
  mattr_accessor :disable_current_account, default: false
  mattr_accessor :locales, default: [I18n.default_locale]
  mattr_accessor :embedded_image_size, default: [2000, 2000]
  mattr_accessor :mailer_defaults, default: ActiveSupport::OrderedOptions.new
  mattr_accessor :thumbnail_image_size, default: [400, 400]
  mattr_accessor :resource_pages_limit_value, default: 25
  mattr_accessor :party_pooper, default: false
  mattr_accessor :tailwind_content
  mattr_accessor :tailwind_plugins
  mattr_accessor :queues
  mattr_accessor :transliterations, default: %i[latin]

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

  self.tailwind_plugins = %w[@tailwindcss/forms @tailwindcss/aspect-ratio @tailwindcss/typography]

  # Images that are embedded in the Trix editor are resized to fit
  # You can optimize this for your website and go for a smaller (or larger) size
  # Default: 2000x2000px
  class << self
    def config
      @config ||= begin
        config = ActiveSupport::OrderedOptions.new

        # Define method_missing to sync with module attributes
        def config.method_missing(method, *args)
          method_name = method.to_s
          if method_name.end_with?('=')
            # Setter
            attr_name = method_name.chomp('=')
            Spina.send("#{attr_name}=", args.first)
            super
          else
            # Getter
            return Spina.send(method) if Spina.respond_to?(method)
            super
          end
        end

        def config.respond_to_missing?(method, include_private = false)
          method_name = method.to_s
          return true if method_name.end_with?('=') && Spina.respond_to?("#{method_name.chomp('=')}=")
          Spina.respond_to?(method) || super
        end

        # Special handling for deprecated methods
        def config.tailwind_purge_content
          Spina.deprecator.warn("config.tailwind_purge_content has been renamed to config.tailwind_content")
          Spina.tailwind_content
        end

        def config.tailwind_purge_content=(paths)
          Spina.deprecator.warn("config.tailwind_purge_content has been renamed to config.tailwind_content")
          Spina.tailwind_content = paths
        end

        def config.embedded_image_size=(image_size)
          if image_size.is_a? String
            Spina.deprecator.warn("Spina embedded_image_size should be set to an array of arguments to be passed to the :resize_to_limit ImageProcessing macro. https://github.com/janko/image_processing/blob/master/doc/minimagick.md#resize_to_limit")
          end
          Spina.embedded_image_size = image_size
        end

        # Initialize with current values
        Spina.instance_variables.each do |var|
          if var.to_s.start_with?('@_mattr_')
            key = var.to_s.sub('@_mattr_', '').to_sym
            config[key] = Spina.instance_variable_get(var)
          end
        end

        config
      end
    end

    def deprecator
      @deprecator ||= ActiveSupport::Deprecation.new("", "Spina")
    end

    def mounted_at
      Spina::Engine.routes.find_script_name({})
    end

    def configure
      yield config
    end
  end
end
