source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec
gem 'rails', '~> 6.1.4'

group :development do
  gem 'letter_opener'
end

group :test do
  gem 'factory_bot'
  gem 'rails-controller-testing'
  gem 'minitest-reporters'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'

  gem 'pry-rails'
  gem 'mocha'

  gem 'puma'
end