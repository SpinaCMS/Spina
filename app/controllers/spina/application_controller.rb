class Spina::ApplicationController < Spina.frontend_parent_controller.constantize
  include Spina.config.authentication.constantize
  include Spina::CurrentSpinaAccount, Spina::CurrentTheme
  
  helper Spina::Engine.helpers
  
  protect_from_forgery with: :exception
end
