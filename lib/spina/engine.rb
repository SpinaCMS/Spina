require 'sass-rails'
require 'turbo-rails'
require 'stimulus-rails'
require 'ancestry'
require 'breadcrumbs_on_rails'
require 'kaminari'
require 'mobility'
require 'rack-rewrite'
require 'attr_json'
require 'view_component/engine'

module Spina
  class Engine < ::Rails::Engine
    isolate_namespace Spina

    config.autoload_paths += %W( #{config.root}/lib )

    config.to_prepare do
      # Load helpers from main application
      Spina::ApplicationController.helper Rails.application.helpers

      unless Spina.config.disable_decorator_load
        # Require decorators from main application
        Dir.glob(Rails.root + "app/decorators/**/*_decorator.rb").each do |decorator|
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

    initializer "spina.helpers" do
      Rails.application.config.assets.configure do |env|
        env.context_class.class_eval { include Spina::ImportmapHelper }
      end
    end
  end
end
