module Spina
  class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    include ApplicationHelper

    private

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def current_theme
      @current_theme = ::Spina::Theme.find_by_name(current_account.theme)
    end
    helper_method :current_theme

    def current_user
      @current_user ||= ::Spina::User.where(id: session[:user_id]).first if session[:user_id]
    end
    helper_method :current_user

    def current_account
      @current_account ||= ::Spina::Account.first
    end
    helper_method :current_account

  end
end
