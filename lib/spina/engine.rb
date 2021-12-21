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
require 'view_component'
require 'jsonapi/serializer'
require 'browser'

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
    
    config.to_prepare do
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
