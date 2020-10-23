require 'haml-rails'
require 'sass-rails'
require 'coffee-rails'
require 'jquery-rails'
require 'turbolinks'
require 'mini_magick'
require 'ancestry'
require 'breadcrumbs_on_rails'
require 'kaminari'
require 'mobility'
require 'rack-rewrite'
require 'jsonb_accessor'
require 'attr_json'

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    config.autoload_paths += %W( #{config.root}/lib )

    config.to_prepare do
      # Load helpers from main application
      Spina::ApplicationController.helper Rails.application.helpers

      unless Spina.config.disable_decorator_load
        # Require decorators from main application
        Dir[Rails.root.join('app', 'decorators', '**', '*_decorator.rb')].flatten.uniq.each do |decorator|
          require_dependency(decorator)
        end
      end

      # Register JSON part types for editing content
      Spina::Part.register(
        Spina::Parts::Line,
        Spina::Parts::MultiLine,
        Spina::Parts::Text,
        Spina::Parts::Image,
        Spina::Parts::ImageCollection,
        Spina::Parts::Repeater,
        Spina::Parts::Option,
        Spina::Parts::Attachment
      )
    end
  end
end
