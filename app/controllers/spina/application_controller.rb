class Spina::ApplicationController < Spina.config.frontend_parent_controller.constantize
  include Spina.config.authentication.constantize
  include Spina::CurrentTheme
  include Spina::CurrentSpinaAccount

  helper Spina::Engine.helpers

  protect_from_forgery with: :exception
end
