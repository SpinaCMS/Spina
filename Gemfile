source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :development do
  gem 'letter_opener'
  gem 'rubocop', '~> 1.39' # ADDITION
  gem 'rubocop-rails', '~> 2.17' # ADDITION
end

# ADDITION
group :development, :test do
  gem 'debug', '>= 1.0.0'
end

group :test do
  gem 'factory_bot'
  gem 'rails-controller-testing'
  
  # CodeClimate
  gem 'minitest-reporters'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  
  # System tests
  gem 'capybara'
  gem 'selenium-webdriver', '~> 4.6.1'
  gem 'webdrivers'

  # gem 'pry-rails' # REMOVED, UNMAINTAINED
  gem 'mocha'

  gem 'puma'
end
