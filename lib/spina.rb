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

  class Configuration
    attr_accessor :api_key,
      :api_path,
      :authentication,
      :backend_title,
      :backend_path,
      :importmap,
      :frontend_parent_controller,
      :disable_frontend_routes,
      :disable_decorator_load,
      :disable_current_account,
      :locales,
      :embedded_image_size,
      :mailer_defaults,
      :thumbnail_image_size,
      :resource_pages_limit_value,
      :party_pooper,
      :tailwind_plugins,
      :queues,
      :transliterations

    def initialize
      @api_key = nil
      @api_path = "api"
      @authentication = "Spina::Authentication::Sessions"
      @backend_title = "Spina CMS"
      @backend_path = "admin"
      @disable_frontend_routes = false
      @disable_decorator_load = false
      @disable_current_account = false
      @embedded_image_size = [2000, 2000]
      @mailer_defaults = ActiveSupport::OrderedOptions.new
      @thumbnail_image_size = [400, 400]
      @frontend_parent_controller = "ApplicationController"
      @locales = [I18n.default_locale]
      @resource_pages_limit_value = 25
      @party_pooper = false
      @transliterations = %i[latin]
      @queues = ActiveSupport::InheritableOptions.new
      @importmap = Importmap::Map.new
      @tailwind_plugins = %w[@tailwindcss/forms @tailwindcss/aspect-ratio @tailwindcss/typography]
    end

    def tailwind_content
      @tailwind_content ||= [
        "#{Spina::Engine.root}/app/views/**/*.*",
        "#{Spina::Engine.root}/app/components/**/*.*",
        "#{Spina::Engine.root}/app/helpers/**/*.*",
        "#{Spina::Engine.root}/app/assets/javascripts/**/*.js",
        "#{Spina::Engine.root}/app/**/application.tailwind.css"
      ]
    end

    attr_writer :tailwind_content
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end
    alias_method :config, :configuration

    def configure
      yield(configuration)
    end

    delegate :locales, to: :config

    def deprecator
      ActiveSupport::Deprecation.new("", "Spina")
    end

    def mounted_at
      Spina::Engine.routes.find_script_name({})
    end
  end
end
