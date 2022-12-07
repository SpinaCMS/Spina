module Spina::Admin
  class LayoutController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_breadcrumb

    admin_section :content

    def edit
    end

    def update
      if @account.update(layout_params)
        redirect_to spina.edit_admin_layout_path(locale: @locale), flash: {success: t("spina.layout.saved")}
      else
        flash.now[:error] = t("spina.layout.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    private

    # Permit all attributes when editing your layout
    def layout_params
      params.require(:account).permit!
    end

    def set_breadcrumb
      add_breadcrumb t("spina.layout.layout")
    end

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || I18n.default_locale
    end
  end
end
