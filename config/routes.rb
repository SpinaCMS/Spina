Spina::Engine.routes.draw do

  # Backend
  namespace :admin do
    root to: "pages#index"

    resource :account do
      member do
        get :style
        get :analytics
        get :social
        get :aviary
      end
    end

    resources :users

    # Sessions
    resources :sessions
    get "login" => "sessions#new"
    get "logout" => "sessions#destroy"

    # Media library
    get 'media_library' => 'photos#index', as: "media_library"

    resources :pages do
      post :sort, on: :collection
    end

    resources :page_parts do
      collection do
        get 'wysihtml5_link/:object_id' => 'page_parts#wysihtml5_link', as: :wysihtml5_link
        post 'wysihtml5_link/:object_id' => 'page_parts#insert_wysihtml5_link'
      end
    end

    resources :attachments do
      collection do
        get 'select/:page_part_id' => 'attachments#select', as: :select
        post 'insert/:page_part_id' => 'attachments#insert', as: :insert
        get 'select_collection/:page_part_id' => 'attachments#select_collection', as: :select_collection
        post 'insert_collection/:page_part_id' => 'attachments#insert_collection', as: :insert_collection
      end
    end

    resources :photos do
      collection do
        get 'wysihtml5_select/:object_id' => 'photos#wysihtml5_select', as: :wysihtml5_select
        post 'wysihtml5_insert/:object_id' => 'photos#wysihtml5_insert', as: :wysihtml5_insert
        get 'photo_select/:page_part_id' => 'photos#photo_select', as: :photo_select
        get 'photo_collection_select/:page_part_id' => 'photos#photo_collection_select', as: :photo_collection_select
        post 'insert_photo/:page_part_id' => 'photos#insert_photo', as: :insert_photo
        post 'insert_photo_collection/:page_part_id' => 'photos#insert_photo_collection', as: :insert_photo_collection
      end
      member do
        post :enhance
        get :link
      end
    end

    resources :inquiries, only: [:index, :show, :destroy] do
      collection do
        get :inbox
        get :spam
      end
      member do
        get :inbox_show
        patch :mark_as_read
        patch :unmark_spam
      end
    end
  end

  # Inquiries
  resources :inquiries

  # Sitemap
  resource :sitemap

  # Robots.txt
  get '/robots', to: 'pages#robots', format: :txt

  # Frontend
  root to: "pages#homepage"

  get ':root/:subpage/:id' => "pages#show", as: "third_level_page"
  get ':root/:id' => "pages#show", as: "subpage"
  get ':id' => "pages#show", as: "page"
end
