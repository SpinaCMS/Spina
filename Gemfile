source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec
gem 'rails', github: 'rails/rails'

group :test do
  gem 'factory_bot'
  gem 'rails-controller-testing'
  gem 'minitest-reporters'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'

  gem 'letter_opener'
  gem 'pry-rails'
  gem 'mocha'
end