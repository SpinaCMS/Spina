module Spina
  module Admin
    class EmbedsController < AdminController
      
      def index
        @embeddables = Spina::Embed.all
        
        if embed_type.present?
          @embeddable = Spina::Embed.constantize(embed_type).new
        else
          @embeddable = @embeddables.first.new
        end
      end
      
      def show
      end
      
      def create
        @embeddable = Spina::Embed.constantize(embed_type).new(embed_params)
      end
      
      private
      
        def embed_type
          params[:embed_type]
        end
      
        def embed_params
          params.permit!
        end
      
    end
  end
end