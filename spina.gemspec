$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'spina/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'spina'
  s.version     = Spina::VERSION
  s.authors     = ['Bram Jetten', 'Harm de Wit']
  s.email       = ['bram@denkgroot.com', 'harm@denkgroot.com']
  s.homepage    = 'http://www.denkgroot.com'
  s.summary     = 'Spina'
  s.description = 'CMS'
  s.licenses    = ['MIT']

  s.files = Dir['{app,config,db,lib,vendor}/**/*'] + ['Rakefile', 'README.md']
  # s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0'
  s.add_dependency 'bcrypt'
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'ancestry'
  s.add_dependency 'breadcrumbs_on_rails'
  s.add_dependency 'turbolinks', '~> 5'
  s.add_dependency 'kaminari'
  s.add_dependency 'globalize', '~> 5.1.0.beta2'
  s.add_dependency 'rack-rewrite', '~> 1.5.0'

  s.add_development_dependency 'factory_girl', '~> 4.0'
end
