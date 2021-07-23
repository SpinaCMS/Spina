module Spina
  class Railtie < Rails::Railtie

    initializer "spina.assets.precompile" do |app|
      app.config.assets.precompile += %w(spina/manifest spina/importmap.json)
    end
    
    ActiveSupport.on_load(:action_controller) do
      ::ActionController::Base.send(:include, Spina::AdminSectionable)
    end

  end
end