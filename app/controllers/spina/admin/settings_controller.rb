module Spina
  module Admin
    class SettingsController < AdminController

      before_action :find_or_set_settings
      before_action :set_breadcrumbs

      def edit
        add_breadcrumb t("spina.#{plugin.namespace}.title")
      end

      def update
        if @settings.update_attributes(settings_params)
          redirect_to spina.admin_edit_settings_path(plugin.namespace)
        else
          add_breadcrumb t("spina.#{plugin.namespace}.title")
          render :edit
        end
      end

      private

      def setting_class
        "spina/#{params[:plugin]}/setting".classify.constantize
      end

      def plugin
        Spina::Plugin.find_by_name(params[:plugin])
      end
      helper_method :plugin

      def find_or_set_settings
        @settings = setting_class.first_or_create do |setting|
          plugin.settings.keys.each do |attribute|
            setting[attribute] = nil
          end
        end
      end

      def set_breadcrumbs
        add_breadcrumb t('spina.settings.title')
      end

      def settings_params
        params.require(:setting).permit(plugin.settings.keys)
      end

    end
  end
end
