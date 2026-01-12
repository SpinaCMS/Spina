# Install Spina CMS

Start by creating a new Rails app. Spina supports PostgreSQL, MySQL, and SQLite databases.

```
rails new yourwebsite --database=postgresql
```

Or for MySQL:
```
rails new yourwebsite --database=mysql
```

Or for SQLite (development only):
```
rails new yourwebsite --database=sqlite3
```

Create a database.

```
rails db:create
```

Run the ActiveStorage installer to install ActiveStorage.

```
rails active_storage:install
```

After that, add the following line to your Gemfile:

```
gem 'spina'
```

Run `bundle install` and run the installer to install Spina CMS.

```
rails spina:install
```

The installer will ask a couple of questions to help you setup your website.

(Re)start your server and access Spina at `/admin`.
