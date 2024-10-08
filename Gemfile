source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :development do
  gem "letter_opener"
end

group :test do
  gem "factory_bot"
  gem "rails-controller-testing"

  # CodeClimate
  gem "minitest-reporters"
  gem "simplecov"
  gem "codeclimate-test-reporter", "~> 1.0.0"

  # Databases
  gem "pg"
  gem "mysql2"
  gem "sqlite3"

  # System tests
  gem "capybara"
  gem "selenium-webdriver", "~> 4.11.0"

  gem "pry-rails"
  gem "mocha"

  gem "puma"
end
