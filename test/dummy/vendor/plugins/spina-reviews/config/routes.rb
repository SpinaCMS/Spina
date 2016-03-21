Spina::Engine.routes.draw do

  namespace :reviews, path: '' do
    namespace :admin, path: Spina.config.backend_path do
      resources :reviews do
        root to: 'reviews#index'
        member do
          post 'confirm'
        end
      end
    end
  end

end
