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

  s.files = Dir['{app,config,db,lib,test}/**/*'] + ['Rakefile', 'README.md']
  # s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'bcrypt-ruby', '~> 3.1'
  s.add_dependency 'haml-rails', '~> 0.8.2'
  s.add_dependency 'sass-rails', '~> 4.0', '>= 4.0.3'
  s.add_dependency 'bourbon', '~> 3.2', '>= 3.2.1'
  s.add_dependency 'neat', '~> 1.5', '>= 1.5.1'
  s.add_dependency 'coffee-rails', '~> 4.0', '>= 4.0.0'
  s.add_dependency 'jquery-rails', '~> 4.0', '>= 4.0.3'
  s.add_dependency 'jquery-fileupload-rails', '~> 0.4.4'
  s.add_dependency 'carrierwave', '~> 0.10.0'
  s.add_dependency 'mini_magick', '~> 4.1', '>= 4.1.0'
  s.add_dependency 'cancan', '~> 1.6', '>= 1.6.10'
  s.add_dependency 'friendly_id', '~> 5.0'
  s.add_dependency 'filters_spam', '~> 0.3'
  s.add_dependency 'negative_captcha', '~> 0.4'
  s.add_dependency 'ancestry', '~> 2.1', '>= 2.1.0'
  s.add_dependency 'breadcrumbs_on_rails', '~> 2.3', '>= 2.3.0'
  s.add_dependency 'spina-template'
  s.add_dependency 'turbolinks'
end
