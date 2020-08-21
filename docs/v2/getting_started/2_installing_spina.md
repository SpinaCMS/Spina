# Install Spina CMS

Start by creating a new Rails app using a PostgreSQL database.

```
rails new yourwebsite --database=postgresql
```

After generating a new app, add the following line to your Gemfile:

```
gem 'spina'
```

Run `bundle install` and run the installer to install Spina CMS.

```
rails g spina:install
```

The installer will ask a couple of questions to help you setup your website.

(Re)start your server and access Spina at `/admin`.
