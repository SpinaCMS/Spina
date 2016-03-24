module Spina
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_theme, :current_user, :current_account

    include ApplicationHelper

    private

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def current_theme
      @current_theme = ::Spina.themes.detect{|theme| theme.name == current_account.theme }
    end

    def current_user
      @current_user ||= Spina::User.where(id: session[:user_id]).first if session[:user_id]
    end

    def current_account
      @current_account ||= Account.first
    end
  end
end
