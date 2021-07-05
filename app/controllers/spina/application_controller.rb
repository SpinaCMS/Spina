class Spina::ApplicationController < Spina.frontend_parent_controller.constantize
  include Spina::CurrentMethods
  include Spina.config.authentication.constantize
  
  helper Spina::Engine.helpers
  
  protect_from_forgery with: :exception
end
