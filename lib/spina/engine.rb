require 'sass-rails'
require 'importmap-rails'
require 'turbo-rails'
require 'stimulus-rails'
require 'ancestry'
require 'breadcrumbs_on_rails'
require 'kaminari'
require 'mobility'
require 'rack-rewrite'
require 'babosa'
require 'attr_json'
require 'view_component/engine'
require 'jsonapi/serializer'

module Spina
  class Engine < ::Rails::Engine
    isolate_namespace Spina
    
    config.autoload_paths += %W( #{config.root}/lib )

    config.to_prepare do
      # Require decorators from main application
      unless Spina.config.disable_decorator_load
        Dir.glob(Rails.root + "app/decorators/**/*_decorator.rb").each do |decorator|
          require_dependency(decorator)
        end
      end
    end
    
    initializer "spina.parts" do
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
    
    initializer "spina.importmap" do
      Spina.config.importmap.draw do
        # Stimulus & Turbo
        pin "@hotwired/stimulus", to: "stimulus.js"
        pin "@hotwired/stimulus-autoloader", to: "stimulus-autoloader.js"
        pin "@hotwired/turbo-rails", to: "turbo.js"
        
        # Spina entrypoint
        pin "application", to: "spina/application.js"
        
        pin_all_from Spina::Engine.root.join("app/assets/javascripts/spina/controllers"), under: "controllers", to: "spina/controllers"
        pin_all_from Spina::Engine.root.join("app/assets/javascripts/spina/libraries"), under: "libraries", to: "spina/libraries"
      end
    end
    
  end
end
