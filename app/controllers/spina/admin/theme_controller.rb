module Spina
  module Admin
    class ThemeController < AdminController
      admin_section :settings
      
      def edit
        add_breadcrumb t('spina.theme.theme')

        theme = Spina::Current.account.theme

        # ADDITION
        # Options from collection for select
        theme_pages = Page.for_theme(theme)

        @theme_pages_select_options = theme_pages.order(:name).pluck(:name, :id)

        @current_homepage = theme_pages.where(is_homepage: true).first
      end
      
      def update
        Spina::Current.account.update(theme_params)
        redirect_to spina.edit_admin_theme_path, flash: {success: t('spina.theme.saved')}

        # ADDITION
        Spina::Page.find(homepage_param).update!(is_homepage: true)
      end
      
      private
      
        def theme_params
          params.require(:account).permit(:theme)
        end

        # ADDITION
        def homepage_param
          params[:account][:page_id]
        end
    end
  end
end
