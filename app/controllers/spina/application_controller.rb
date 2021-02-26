class Spina::ApplicationController < Spina.frontend_parent_controller.constantize
  include Spina::CurrentMethods
  
  helper Spina::Engine.helpers
  
  protect_from_forgery with: :exception
end
