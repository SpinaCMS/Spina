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
require 'negative_captcha'
require 'filters_spam'
require 'ancestry'
require 'breadcrumbs_on_rails'
require 'kaminari'
require 'globalize'
require 'rack-rewrite'

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    config.autoload_paths += %W( #{config.root}/lib )
    config.assets.paths << config.root.join('vendor', 'assets')

    initializer 'spina.configure_carrierwave' do
      CarrierWave.configure do |cfg|
        if Spina.config.storage == :s3
          cfg.storage = :fog
          cfg.fog_credentials = {
            provider:               'AWS',
            region:                 Spina.config.aws_region,
            aws_access_key_id:      Spina.config.aws_access_key_id,
            aws_secret_access_key:  Spina.config.aws_secret_key
          }
          cfg.fog_directory  = Spina.config.s3_bucket
          cfg.fog_public     = true
          cfg.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
        else
          cfg.storage = :file
        end

        cfg.enable_processing = !Rails.env.test?
      end
    end

    config.to_prepare do
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

  end
end
