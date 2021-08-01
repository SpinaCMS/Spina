# Enabling the API

🚧 _Spina's API is currently in beta, it includes the most important endpoints but is not yet complete._

You enable the API by setting an API key in the initializer. It's highly recommended to use [Rails credentails](https://guides.rubyonrails.org/security.html#custom-credentials) to store your API key.

```
# config/initializers/spina.rb
Spina.configure do |config|
  # ...
  config.api_key = Rails.application.credentials.spina_api_key
end
```