Spina::Engine.routes.draw do

  namespace :reviews, path: nil do
    namespace :admin, path: Spina.config.backend_path do
      resources :reviews do
        member do
          post 'confirm'
        end
      end
    end
  end

end
