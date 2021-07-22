module Spina
  module Admin
    class AccountsController < AdminController
      admin_section :settings
      
      before_action :set_breadcrumbs

      def edit
      end

      def update
        if current_account.update(account_params)
          redirect_back fallback_location: spina.edit_admin_account_path, flash: {success: t('spina.accounts.saved')}
        else
          flash.now[:error] = t('spina.accounts.couldnt_be_saved')
          render :edit, status: :unprocessable_entity
        end
      end

      private

        def account_params
          params.require(:account).permit!
        end
        
        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.preferences.account'), spina.edit_admin_account_path
        end

    end
  end
end
