module Spina
  module Admin
    class UsersController < AdminController
      before_action :authorize_authentication_module
      before_action :authorize_admin, except: [:index]
      before_action :set_user, only: [:edit, :update, :destroy]
      
      admin_section :settings

      def index
        @users = User.order(:name)
        add_breadcrumb I18n.t('spina.preferences.users'), spina.admin_users_path
      end

      def new
        @user = User.new
        add_index_breadcrumb
        add_breadcrumb I18n.t('spina.users.new')
      end

      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_users_url
        else
          flash.now[:alert] = I18n.t('spina.users.cannot_be_created')
          add_index_breadcrumb
          add_breadcrumb I18n.t('spina.users.new')
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        add_index_breadcrumb
        add_breadcrumb "#{@user}"
      end

      def update
        if @user.update(user_params)
          flash[:success] = t('spina.users.saved')
          redirect_to spina.admin_users_url
        else
          flash.now[:alert] = I18n.t('spina.users.cannot_be_created')
          add_index_breadcrumb
          add_breadcrumb "#{@user}"
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @user != current_spina_user
          @user.destroy 
          redirect_to spina.admin_users_url, flash: {success: t('spina.users.deleted')}
        end
      end

      private

        def add_index_breadcrumb
          add_breadcrumb I18n.t('spina.preferences.users'), spina.admin_users_path, class: 'text-gray-400'
        end

        def user_params
          params.require(:user).permit(:admin, :email, :name, :password_digest, :password, :password_confirmation, :last_logged_in)
        end

        def set_user
          @user = User.find(params[:id])
        end
        
        def authorize_authentication_module
          render status: 401 unless Spina.config.authentication == "Spina::Authentication::Sessions"
        end
        
        def authorize_admin
          render status: 401 unless current_spina_user.admin?
        end
        
    end
  end
end
