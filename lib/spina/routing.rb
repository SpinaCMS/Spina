class ActionDispatch::Routing::Mapper
  
  def spina_routes(path: "/")
    # get "/rails/active_storage/blobs/:signed_id/*filename" => "active_storage/blobs#show", as: :rails_service_blob#, internal: true

    scope module: :spina, as: :spina do
      namespace :admin, path: Spina.config.backend_path do
        root to: "pages#index"

        resource :account do
          member do
            get :style
            get :analytics
            get :social
          end
        end

        get "/settings/:plugin", to: "settings#edit", as: :edit_settings
        patch "/settings/:plugin", to: "settings#update", as: :settings

        resources :users

        # Sessions
        resources :sessions
        get "login" => "sessions#new"
        get "logout" => "sessions#destroy"

        # Passwords
        resources :password_resets

        # Media library
        get 'media_library' => 'photos#media_library', as: "media_library"

        resources :pages do
          post :sort, on: :collection
        end

        resources :navigations do
          post :sort, on: :member
        end

        resources :attachments do
          collection do
            get 'select/:page_part_id' => 'attachments#select', as: :select
            post 'insert/:page_part_id' => 'attachments#insert', as: :insert
            get 'select_collection/:page_part_id' => 'attachments#select_collection', as: :select_collection
            post 'insert_collection/:page_part_id' => 'attachments#insert_collection', as: :insert_collection
          end
        end

        resources :media_folders

        resources :photos do
          collection do
            get 'trix_select/:object_id' => 'photos#trix_select', as: :trix_select
            post 'trix_insert/:object_id' => 'photos#trix_insert', as: :trix_insert
            get 'photo_select/:page_part_id' => 'photos#photo_select', as: :photo_select
            get 'photo_collection_select/:page_part_id' => 'photos#photo_collection_select', as: :photo_collection_select
            post 'insert_photo/:page_part_id' => 'photos#insert_photo', as: :insert_photo
            post 'insert_photo_collection/:page_part_id' => 'photos#insert_photo_collection', as: :insert_photo_collection
            get 'folder/:id' => 'photos#media_folder', as: :media_folder
            put 'folder/:id' => 'photos#add_to_media_folder', as: :add_to_media_folder
          end
        end

        resources :images do
          collection do
            get 'image_select/:page_part_id' => 'images#photo_select', as: :image_select
            post 'insert_image' => 'images#insert_image', as: :insert_image
          end
        end
      end

      # Sitemap
      resource :sitemap

      # Robots.txt
      get '/robots', to: 'pages#robots', constraints: { format: 'txt' }

      unless Spina.config.disable_frontend_routes
        # Frontend
        root to: "pages#homepage"

        # Pages
        get '/:locale/*id' => 'pages#show', constraints: {locale: /#{Spina.config.locales.join('|')}/ }
        get '/:locale/' => 'pages#homepage', constraints: {locale: /#{Spina.config.locales.join('|')}/ }
        get '/*id' => 'pages#show', as: "page", controller: 'pages', constraints: lambda { |request|
          !(Rails.env.development? && request.env['PATH_INFO'].starts_with?('/rails/') || request.env['PATH_INFO'].starts_with?("/#{Spina.config.backend_path}") || request.env['PATH_INFO'].starts_with?('/attachments/'))
        }
      end
    end
  end

end