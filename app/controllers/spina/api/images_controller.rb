module Spina
  module Api
    class ImagesController < ApiController
      
      def show
        @image = Spina::Image.find(params[:id])
        render json: Spina::Api::ImageSerializer.new(@image, {params: {view_context: view_context}}).serializable_hash.to_json
      end
      
    end
  end
end