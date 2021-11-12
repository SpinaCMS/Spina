# Existing project

If you already have an existing Rails project, just add `gem "spina"` to your Gemfile and run `bundle install`. (Make sure you're using PostgreSQL as your database)

Run the installer to get started.

```
rails spina:install
```

The installer will help you setup your first user.
Restart your server and access Spina at `/admin`.

If you're already using `/admin` for something else, you can change that in `config/initializers/spina.rb`.
