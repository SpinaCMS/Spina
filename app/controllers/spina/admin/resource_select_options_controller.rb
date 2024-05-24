module Spina
  module Admin
    class ResourceSelectOptionsController < AdminController

      def show
        @resource = Resource.find(params[:id])
      end

      def index
      end

      def search
        @resources ||= Resource.all
        @resources = @resources.where("name ILIKE :query OR label ILIKE :query", query: "%#{params[:search]}%").order(created_at: :desc).distinct.page(params[:page]).per(20)
        render :index
      end

    end
  end
end
