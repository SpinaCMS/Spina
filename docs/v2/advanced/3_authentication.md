# Authentication

By default, Spina CMS includes basic user management using it's own `Spina::User` model. If you're adding Spina to an existing app, you might already have some form of authentication that you want to use for Spina.

You can do that by creating a module with two methods: `authenticate` and `logged_in?`. Here's an example of a project using it's own `session[:user_id]`:

```ruby
module MyApp
  module CustomAuth
    extend ActiveSupport::Concern
    
    included do
      helper_method :logged_in?
      helper_method :current_user
    end
    
    def logged_in?
      current_user
    end
    
    def current_user
      @current_user ||= MyApp::User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    private
    
      def authenticate
        redirect_to "/login" unless logged_in?
      end
      
  end
end
```

After creating the module, you need to configure it in `config/initializers/spina.rb`:

```
Spina.configure do |config|
  # ...
  config.authentication = "MyApp::CustomAuth"
end
```