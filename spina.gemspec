$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spina/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = 'spina'
  gem.version     = Spina::VERSION
  
  gem.authors     = ['Bram Jetten']
  gem.email       = ['bram@denkgroot.com']
  gem.homepage    = 'https://www.spinacms.com'
  gem.summary     = 'Spina'
  gem.description = 'CMS'
  gem.license     = 'MIT'
  
  gem.metadata = {
    "homepage_uri" => "https://www.spinacms.com",
    "bug_tracker_uri" => "https://github.com/SpinaCMS/Spina/issues",
    "documentation_uri" => "https://www.spinacms.com/docs",
    "changelog_uri" => "https://github.com/SpinaCMS/Spina/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/SpinaCMS/Spina",
  }

  gem.files = Dir['{app,config,db,lib,vendor}/**/*'] + ['Rakefile', 'README.md']

  gem.add_dependency 'rails', '>= 6.0'
  gem.add_dependency 'pg'
  gem.add_dependency 'bcrypt'
  gem.add_dependency 'sass-rails'
  gem.add_dependency 'image_processing'
  gem.add_dependency 'ancestry'
  gem.add_dependency 'breadcrumbs_on_rails'
  gem.add_dependency 'kaminari'
  gem.add_dependency 'mobility', '>= 1.1.3'
  gem.add_dependency 'rack-rewrite', '>= 1.5.0'
  gem.add_dependency 'attr_json'
  gem.add_dependency 'view_component', '~> 2.32'
  gem.add_dependency 'importmap-rails', '0.5.0'
  gem.add_dependency 'turbo-rails', '~> 0.7.4'
  gem.add_dependency 'stimulus-rails', '>= 0.3.8', '< 0.5.0'
  gem.add_dependency 'babosa'
  gem.add_dependency 'jsonapi-serializer'
  gem.add_dependency 'browser'
end
