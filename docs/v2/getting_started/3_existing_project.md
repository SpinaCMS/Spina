# Existing project

If you already have an existing Rails project, just add `gem "spina"` to your Gemfile and run `bundle install`. (Make sure you're using PostgreSQL as your database)

Run the installer to get started.

```
rails spina:install
```

The installer will help you setup your first user.
Restart your server and access Spina at `/admin`.

If you're already using `/admin` for something else, you can change that in `config/initializers/spina.rb`.

## Mounting path

The default mount path for Spina is at the root of your Rails app "/":

```ruby
mount Spina::Engine => "/"
```

You can change this to a subdirectory like this:

```ruby
mount Spina::Engine => "/blog"
```

Keep in mind that when pages are saved, the URLs are stored in the database as "materialized paths". Changing Spina's mount path means you have to regenerate all materialized paths. You can do that by calling `.save` on each page.