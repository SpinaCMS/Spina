module Spina
  module Api
    class NavigationsController < ApiController
      include Paginable

      def index
        navigations = Navigation.order(:id)
        paginated = pagination(navigations)
        render json: Spina::Api::NavigationSerializer.new(paginated.first, paginated.last.merge(fields: {navigation: [:name, :label]})).serializable_hash.to_json
      end

      def show
        @navigation = Navigation.find(params[:id])
        render json: Spina::Api::NavigationSerializer.new(@navigation).serializable_hash.to_json
      end
    end
  end
end
