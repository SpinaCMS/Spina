module Spina
  module Hooks
    class PartialComponent < ApplicationComponent
      with_collection_parameter :plugin
      
      def initialize(plugin:, partial:)
        @plugin = plugin
        @partial = partial
      end
      
      def call
        render partial: "spina/admin/hooks/#{@plugin.namespace}/#{@partial}"
      end
      
      def render?
        helpers.lookup_context.exists? "spina/admin/hooks/#{@plugin.namespace}/_#{@partial}"
      end
      
    end
  end
end