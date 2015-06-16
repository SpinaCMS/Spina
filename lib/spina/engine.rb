require 'haml-rails'
require 'sass-rails'
require 'bourbon'
require 'neat'
require 'coffee-rails'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'turbolinks'
require 'carrierwave'
require 'mini_magick'
require 'cancan'
require 'friendly_id'
require 'negative_captcha'
require 'filters_spam'
require 'ancestry'
require 'breadcrumbs_on_rails'

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    def self.require_decorators
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

    initializer "spina.configure_carrierwave" do
      CarrierWave.configure do |cfg|
        if Engine.config.try(:storage) == :s3
          cfg.storage = :fog
          cfg.fog_credentials = {
            provider: 'AWS',
            region: Engine.config.aws_region,
            aws_access_key_id: Engine.config.aws_access_key_id,
            aws_secret_access_key: Engine.config.aws_secret_key
          }
          cfg.fog_directory  = Engine.config.s3_bucket
          cfg.fog_public     = true
          cfg.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
        else
          cfg.storage = :file
        end

        cfg.enable_processing = !Rails.env.test?
      end
    end

    config.to_prepare &method(:require_decorators).to_proc
    config.autoload_paths += %W( #{config.root}/lib )
  end

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
