module Spina
  module Admin
    class ResourcesController < AdminController

      def show
        @resource = Resource.find(params[:id])
        add_breadcrumb @resource.label
      end

    end
  end
end