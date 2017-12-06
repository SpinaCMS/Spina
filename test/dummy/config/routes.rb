Rails.application.routes.draw do
  # mount Spina::Engine => '/'
  spina_routes path: "/"
end
