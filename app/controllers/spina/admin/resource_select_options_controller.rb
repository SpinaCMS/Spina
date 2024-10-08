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
        @resources = @resources.where("LOWER(name) LIKE LOWER(:query) OR LOWER(label) LIKE LOWER(:query)", query: "%#{params[:search]}%").order(created_at: :desc).distinct.page(params[:page]).per(20)
        render :index
      end

    end
  end
end
