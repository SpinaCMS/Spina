Spina.config.importmap.draw do
  # Stimulus & Turbo
  pin "@hotwired/stimulus", to: "stimulus.js"
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
  pin "@hotwired/turbo-rails", to: "turbo.js"
  
  # Spina entrypoint
  pin "application", to: "spina/application.js"
  
  pin_all_from Spina::Engine.root.join("app/assets/javascripts/spina/controllers"), under: "controllers", to: "spina/controllers"
  pin_all_from Spina::Engine.root.join("app/assets/javascripts/spina/libraries"), under: "libraries", to: "spina/libraries"
end