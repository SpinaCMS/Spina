module Spina
  class Railtie < Rails::Railtie

    initializer "spina.assets.precompile" do |app|
      app.config.assets.precompile += %w(spina/manifest)
    end
    
    initializer "spina.reloader" do |app|
      reloader = Reloader.new
      reloader.execute
      
      app.reloaders << reloader
      app.reloader.to_run do
        reloader.execute
      end
    end
    
    ActiveSupport.on_load(:action_controller) do
      ::ActionController::Base.send(:include, Spina::AdminSectionable)
    end

  end
end