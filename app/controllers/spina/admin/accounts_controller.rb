module Spina
  module Admin
    class AccountsController < AdminController

      def edit
        add_breadcrumb I18n.t('spina.preferences.account'), spina.edit_admin_account_path
      end

      def update
        current_account.update_attributes(account_params)
        redirect_back fallback_location: spina.edit_admin_account_path
      end

      def analytics
        add_breadcrumb I18n.t('spina.preferences.analytics'), spina.analytics_admin_account_path
      end

      def social
        add_breadcrumb I18n.t('spina.preferences.social_media'), spina.social_admin_account_path
      end

      def style
        add_breadcrumb I18n.t('spina.preferences.style'), spina.style_admin_account_path
        @themes = ::Spina::Theme.all
        @layout_parts = current_theme.layout_parts.map { |layout_part| current_account.layout_part(layout_part) }
      end

      private

      def account_params
        params.require(:account).permit(:address, :city, :email, :logo, :name, :phone,
                                        :postal_code, :preferences, :google_analytics,
                                        :google_site_verification, :facebook, :twitter, :google_plus,
                                        :kvk_identifier, :theme, :vat_identifier, :robots_allowed,
                                        layout_parts_attributes:
                                          [:id, :layout_partable_type, :layout_partable_id,
                                            :name, :title, :position, :content, :page_id,
                                            layout_partable_attributes:
                                              [:content, :photo_tokens, :attachment_tokens, :id]])
      end
    end
  end
end
