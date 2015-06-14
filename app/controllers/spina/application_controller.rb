module Spina
  class ApplicationController < ActionController::Base
    include ApplicationHelper

    private

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def current_theme
      @current_theme = Spina.theme(current_account.theme) || ::Spina.themes.first
    end
    helper_method :current_theme

    def current_user
      @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
    end
    helper_method :current_user

    def current_account
      @current_account ||= Account.find_by(custom_domain: request.host) || Account.find_by(subdomain: request.subdomain) || Account.first
    end
    helper_method :current_account
  end
end
