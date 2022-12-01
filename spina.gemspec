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
  
  gem.required_ruby_version     = ">= 2.7.0"
  
  gem.metadata = {
    "homepage_uri" => "https://www.spinacms.com",
    "bug_tracker_uri" => "https://github.com/SpinaCMS/Spina/issues",
    "documentation_uri" => "https://www.spinacms.com/docs",
    "changelog_uri" => "https://github.com/SpinaCMS/Spina/blob/main/CHANGELOG.md",
    "source_code_uri" => "https://github.com/SpinaCMS/Spina",
  }

  gem.files = Dir['{app,config,db,lib,vendor}/**/*'] + ['Rakefile', 'README.md']

  gem.add_dependency "standard"
end
