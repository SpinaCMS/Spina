module Spina
  module Admin
    class UsersController < AdminController
      before_filter :set_breadcrumbs
      
      authorize_resource class: User

      layout "spina/admin/settings"

      def index
        @users = User.all
      end

      def new
        @user = User.new
        add_breadcrumb "Nieuwe gebruiker"
      end

      def create
        @user = User.new(user_params)
        add_breadcrumb "Nieuwe gebruiker"
        if @user.save
          redirect_to admin_users_url, notice: "Gebruiker #{@user} is aangemaakt."
        else
          flash.now[:alert] = "De gebruiker kan nog niet worden opgeslagen."
          render :new
        end
      end

      def edit
        @user = User.find(params[:id])
        add_breadcrumb "#{@user}"
      end

      def update
        @user = User.find(params[:id])
        add_breadcrumb "#{@user}"
        if @user.update_attributes(user_params)
          redirect_to spina.admin_users_url
        else
          flash.now[:alert] = "De gebruiker kan nog worden opgeslagen."
          render :edit
        end
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy unless @user == current_user
        redirect_to admin_users_url, notice: "De gebruiker is verwijderd."
      end

      private

      def set_breadcrumbs
        add_breadcrumb "Gebruikers", spina.admin_users_path
      end

      def user_params
        params.require(:user).permit(:admin, :email, :name, :password_digest, :password, :password_confirmation, :last_logged_in)
      end
      
    end
  end
end
