module Spina
  class Railtie < Rails::Railtie
    initializer "spina.configure_rails_initialization" do
      Rails.application.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
        r301 %r{^/(.*)/$}, '/$1'
      end
    end
  end
end