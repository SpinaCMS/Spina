module Spina
  module Admin
    class PageTranslationsController < AdminController
      def destroy
        @translation = Spina::Page::Translation.find(params[:id])
        @translation.destroy
        flash[:info] = t("spina.page_translations.deleted")
        redirect_to spina.edit_admin_page_path(@translation.translated_model), status: :see_other
      end
    end
  end
end
