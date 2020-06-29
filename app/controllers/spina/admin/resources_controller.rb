module Spina
  module Admin
    class ResourcesController < AdminController
      before_action :set_locale
      before_action :set_resource, only: [:show, :edit, :update]

      def show        
        add_breadcrumb @resource.label
      end

      def edit        
        add_breadcrumb @resource.label, spina.admin_resource_path(@resource)
        add_breadcrumb t('spina.edit')
      end

      def update
        if Mobility.with_locale(@locale) { @resource.update(resource_params) }
          redirect_to spina.admin_resource_path(@resource)
        else
          render :edit
        end
      end

      private

        def resource_params
          params.require(:resource).permit(:label, :slug, :view_template, :order_by, :parent_page_id)
        end

        def set_resource
          @resource = Resource.find(params[:id])          
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
        end

    end
  end
end