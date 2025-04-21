$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spina/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name = "spina"
  gem.version = Spina::VERSION

  gem.authors = ["Bram Jetten"]
  gem.email = ["bram@denkgroot.com"]
  gem.homepage = "https://www.spinacms.com"
  gem.summary = "Spina"
  gem.description = "CMS"
  gem.license = "MIT"
  gem.post_install_message = %q{
    Spina v2.16 includes a new migration, don't forget to run spina:install:migrations.

    For details on this specific release, refer to the CHANGELOG file.
    https://github.com/SpinaCMS/Spina/blob/main/CHANGELOG.md#2160-august-23rd-2022
  }

  gem.required_ruby_version = ">= 2.7.0"

  gem.metadata = {
    "homepage_uri" => "https://www.spinacms.com",
    "bug_tracker_uri" => "https://github.com/SpinaCMS/Spina/issues",
    "documentation_uri" => "https://www.spinacms.com/docs",
    "changelog_uri" => "https://github.com/SpinaCMS/Spina/blob/main/CHANGELOG.md",
    "source_code_uri" => "https://github.com/SpinaCMS/Spina"
  }

  gem.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["Rakefile", "README.md"]

  gem.add_dependency "rails", ">= 7.0", "< 9.0"
  gem.add_dependency "pg"
  gem.add_dependency "bcrypt"
  gem.add_dependency "image_processing"
  gem.add_dependency "ancestry"
  gem.add_dependency "breadcrumbs_on_rails"
  gem.add_dependency "kaminari"
  gem.add_dependency "mobility", ">= 1.3.0"
  gem.add_dependency "rack-rewrite", ">= 1.5.0"
  gem.add_dependency "attr_json"
  gem.add_dependency "view_component", ">= 2.32", "< 4.0"
  gem.add_dependency "importmap-rails", ">= 0.7.6"
  gem.add_dependency "turbo-rails", ">= 0.9", "< 3.0"
  gem.add_dependency "stimulus-rails", ">= 0.7.0"
  gem.add_dependency "babosa"
  gem.add_dependency "jsonapi-serializer"
  gem.add_dependency "browser"
  gem.add_dependency "tailwindcss-ruby"
end
