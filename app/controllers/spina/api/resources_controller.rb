module Spina
  module Api
    class ResourcesController < ApiController
      include Paginable

      def index
        resources = Resource.order(:id)
        render json: Spina::Api::ResourceSerializer.new(*pagination(resources)).serializable_hash.to_json
      end

      def show
        @resource = Resource.find(params[:id])
        render json: Spina::Api::ResourceSerializer.new(@resource).serializable_hash.to_json
      end
    end
  end
end
