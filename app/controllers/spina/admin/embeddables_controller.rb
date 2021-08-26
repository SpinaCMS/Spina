module Spina
  module Admin
    class EmbeddablesController < AdminController
      
      def index
        @embeddables = Spina::Embed.all
      end
      
      def create
        @embeddable = Spina::Embeds::Youtube.new(embed_params)
      end
      
      private
      
        def embed_params
          params.permit!
        end
      
    end
  end
end