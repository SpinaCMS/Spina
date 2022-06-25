# frozen_string_literal: true

module Spina
  module Admin
    class ResourcesController < AdminController
      before_action :set_locale
      before_action :set_resource, only: [:edit, :update]

      def new
        add_breadcrumb I18n.t("spina.resources.new")
        @resource = Resource.new
      end

      def index
        add_breadcrumb I18n.t("spina.website.resources"), spina.admin_resources_path
        @resources = Resource.all
      end

      def create
        @resource = Resource.new(resource_params)

        if Mobility.with_locale(@locale) { @resource.save }
          flash[:success] = t("spina.resources.saved")
          redirect_to spina.admin_pages_path(resource_id: @resource.id)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb @resource.label, spina.admin_pages_path(resource_id: @resource.id), class: "text-gray-400"
        add_breadcrumb t("spina.edit")
      end

      def update
        if Mobility.with_locale(@locale) { @resource.update(resource_params) }
          flash[:success] = t("spina.resources.saved")
          redirect_to spina.admin_pages_path(resource_id: @resource.id)
        else
          add_breadcrumb @resource.label, spina.admin_pages_path(resource_id: @resource.id), class: "text-gray-400"
          add_breadcrumb t("spina.edit")
          render :edit
        end
      end

      private

      def resource_params
        params.require(:resource)
          .permit(:label, :name, :slug, :view_template, :order_by, :parent_page_id)
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
