Rails.application.routes.draw do
  root "dummy#show"
  resources :images

  mount Spina::Engine => '/'
end
