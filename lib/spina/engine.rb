require 'spina'
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

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    config.autoload_paths += %W( #{config.root}/lib )
    config.assets.paths << config.root.join('vendor', 'assets')

    config.to_prepare do
      # Load helpers from main application
      Spina::ApplicationController.helper Rails.application.helpers

      # Require decorators from main application
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end
  end
end
