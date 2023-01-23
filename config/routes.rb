Rails.application.routes.draw do
  if ActiveStorage.respond_to?(:resolve_model_to_route)
    resolve("Spina::Parts::Image") { |image, options| route_for(ActiveStorage.resolve_model_to_route, image, options) }
    resolve("Spina::Parts::ImageVariant") { |image, options| route_for(ActiveStorage.resolve_model_to_route, image, options) }
    resolve("Spina::Parts::Attachment") { |attachment, options| route_for(ActiveStorage.resolve_model_to_route, attachment, options) }
  else
    resolve("Spina::Parts::Image") { |image, options| route_for(:rails_blob, image, options) }
    resolve("Spina::Parts::ImageVariant") { |image, options| route_for(:rails_representation, image, options) }
    resolve("Spina::Parts::Attachment") { |attachment, options| route_for(:rails_blob, attachment, options) }
  end
end

Spina::Engine.routes.draw do
  # API
  namespace :api, path: Spina.config.api_path do
    resources :pages, only: [:index, :show]
    resources :navigations, only: [:index, :show]
    resources :resources, only: [:index, :show] do
      resources :pages, only: [:index, :show]
    end
    resources :images, only: [:show]
  end

  # Backend
  namespace :admin, path: Spina.config.backend_path do
    root to: "pages#index"

    resource :account
    resource :theme, controller: :theme

    get "/settings/:plugin", to: "settings#edit", as: :edit_settings
    patch "/settings/:plugin", to: "settings#update", as: :settings

    resources :users

    # Sessions
    resources :sessions
    get "login" => "sessions#new"
    get "logout" => "sessions#destroy"

    # Passwords
    resources :password_resets

    resources :pages do
      member do
        get :edit_content
        get :edit_template
        get :children
        post :sort_one
      end
      
      collection do
        post :sort
      end

      resource :move, controller: "move_pages"
    end
    resources :page_select_options, only: [:show, :index] do
      post :search, on: :collection
    end
    resources :page_translations, only: [:destroy]
    resources :parent_pages
    resource :layout, controller: :layout, only: [:edit, :update]

    resources :resources, only: [:show, :edit, :update]

    resources :navigations, only: [:index, :edit, :update] do
      post :sort, on: :member
      resources :navigation_items
    end

    resources :attachments do
      post :inline_upload, on: :collection
    end
    resources :rename_files

    resources :media_folders do
      resources :images
    end

    resources :images

    resource :media_picker, controller: "media_picker", only: [:show]

    resources :embeds, only: [:new, :create]
  end

  # Sitemap
  resource :sitemap

  unless Spina.config.disable_frontend_routes
    # Frontend
    root to: "pages#homepage"

    # Pages
    get "/:locale/*id" => "pages#show", :constraints => {locale: /#{Spina.locales.join('|')}/}
    get "/:locale/" => "pages#homepage", :constraints => {locale: /#{Spina.locales.join('|')}/}
    get "/*id" => "pages#show", :as => "page", :controller => "pages", :constraints => ->(request) {
      request.path.exclude?(ActiveStorage.routes_prefix) &&
        !(Rails.env.development? && request.path.starts_with?("/rails/"))
    }
  end
end
