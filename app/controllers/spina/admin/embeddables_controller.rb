module Spina
  module Admin
    class EmbeddablesController < AdminController
      
      def index
      end
      
      def create
        @embeddable = Spina::Embeddable::Youtube.new(embed_params)
      end
      
      private
      
        def embed_params
          params.permit(:id)
        end
      
    end
  end
end