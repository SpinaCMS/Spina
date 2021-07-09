module Spina
  module Hooks
    class HookComponent < ApplicationComponent
      
      def initialize(partial:)
        @partial = partial
      end
      
      def call
        render Spina::Hooks::PartialComponent.with_collection(plugins, partial: @partial)
      end
      
      def plugins
        Spina::Plugin.all.find_all do |plugin|
          helpers.current_theme.plugins.include?(plugin.name)
        end
      end
      
    end
  end
end