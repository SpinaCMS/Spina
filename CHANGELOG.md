# Spina CMS Changelog

## 2.0

⚠️ _Beware: lots of changes regarding page content. The old page parts are gone in favor of new JSON-based parts. Read the [Upgrading Guide](https://www.spinacms.com/guide/getting-started/upgrading-from-v1) to learn how to upgrade._

### 2.0.0 (March 13th, 2021)
_No changes since beta_

### 2.0.0.beta (March 5th, 2021)

* Resize images embedded in Trix (configurable in spina.rb)
* Added `Spina::Parts::MultiLine`
* Added `frontend_parent_controller` (configurable in spina.rb)
* Removed html5shiv
* Updated Mobility to 1.0 and updated included initializer
* Fixed url_helpers for images to support `resolve_model_to_route` in Rails 6.1
* Fixed bug (#655) for pages with duplicate titles

### 2.0.0.alpha (June 29th, 2020)

* __Replaced all page content with JSON-based Spina::Parts__
* Redesigned page editing
* Redesigned media picker
* Added content helpers
* Added json content to Spina::Account
* Added tests for better test coverage
* Added slug to Spina::Resource
* Removed `Spina::PagePart` and related models
* Fixed MenuPresenter for pages without translations
* Refactored jQuery as Stimulus controllers

## 1.2

### 1.2.0 (June 29th, 2020)

* Added support for custom slugs (remember to install the new migration)

## 1.1

### 1.1.4 (May 8, 2020)

* Allow SVGs to be displayed
* Fixed bug with @extend in sass files
* Improved translations

### 1.1.3 (December 25, 2019)

* Added missing icons to Trix editor

### 1.1.2 (December 20, 2019)

* Change Spina's admin font to Metropolis
* Add missing translations for Spanish
* Add missing translations for Italian
* Rename media folders
* Cleaner Readme.md and guides
* Removed Font Awesome dependency

### 1.1.1 (November 11, 2019)

* Dropped the requirement for Rails to >= 5.2.

### 1.1.0 (November 3, 2019)

* Support for Rails 6
* Support for Sprockets 4
* Better image management using media folders
* Upgrade Trix
* Added documentation
* Bump gem dependencies
* Add support for alt texts and links to images in Trix