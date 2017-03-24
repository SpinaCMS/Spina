require 'haml-rails'
require 'sass-rails'
require 'bourbon'
require 'coffee-rails'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'turbolinks'
require 'carrierwave'
require 'mini_magick'
require 'cancancan'
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

    config.to_prepare do
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

  end
end
