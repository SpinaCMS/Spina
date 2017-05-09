module Spina
  module Admin
    class PasswordResetsController < AdminController
      layout "spina/login"

      skip_before_action :authorize_spina_user

      def new
      end

      def create
        user = User.find_by(email: params[:email])

        if user.present?
          user.regenerate_password_reset_token
          user.update_attributes!(password_reset_sent_at: Time.zone.now)
          UserMailer.forgot_password(user).deliver_now
          redirect_to admin_login_path, flash: {success: t('spina.forgot_password.instructions_sent')}
        else
          flash.now[:alert] = t('spina.forgot_password.unknown_user')
          render :new
        end
      end

      def edit
        @user = User.find_by!(password_reset_token: params[:id])
      end

      def update
        @user = User.find_by(password_reset_token: params[:id])

        if @user.password_reset_sent_at < 2.hours.ago
          redirect_to new_admin_password_reset_path, flash: {alert: t('spina.forgot_password.expired')}
        elsif @user.update_attributes(user_params)
          redirect_to admin_login_path, flash: {success: t('spina.forgot_password.success')}
        else
          render :edit
        end
      end

      private

        def user_params
          params.require(:user).permit(:password, :password_confirmation)
        end

    end
  end
end