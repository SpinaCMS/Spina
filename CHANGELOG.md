# Spina CMS Changelog

## 2.8

### 2.8.1 (January 29nd, 2022)
* Added hints to parts when editing pages
* Fixed bug with signed_id for Attachment
* Fixed bug with tailwind_content not loading properly

### 2.8.0 (January 14th, 2022)
* Upgraded to Tailwind 3 JIT
* Added locale switch to layout form
* Fixed missing French translations
* Fixed z-index bug in Trix
* Fixed Trix CSS bugs
* Fixed ImageCollection bug with sortable
* Updated gem dependencies

## 2.7

### 2.7.0 (December 23rd, 2021)
* Added support for Rails 7
* Fixed ActiveStorage bugs

## 2.6

### 2.6.2 (December 22nd, 2021)
* Updated gem dependencies

### 2.6.1 (December 10th, 2021)
* Removed sass-rails dependency

### 2.6.0 (December 9th, 2021)
* Spina CMS now requires Ruby 2.7+
* Added Embed generator for Trix
* Added --silent option to install generator
* Added --first-deploy option to install generator
* Added spina:first_deploy task
* Added support for different mount paths
* Fixed routes catch all bug
* Updated gem dependencies

## 2.5

### 2.5.0 (October 17th, 2021)
* Added custom embeds in Trix
* Added auto-reloading themes
* Added default position to new pages
* Refactored loading of Stimulus controllers
* Refactored autoloading of objects during initialization
* Updated dependencies
* Fixed flash pointer events

## 2.4

### 2.4.0 (September 9th, 2021)
* Added option to exclude view templates from resources
* Added HTML email templates
* Added configurable mailer defaults
* Updated Hotwire dependencies
* Fixed exception for missing image attachments
* Refactored importmap config to importmap.rb

## 2.3

### 2.3.5 (August 22nd, 2021)
* Changed to esm-compatible build of Trix to fix bug in Firefox

### 2.3.4 (August 17th, 2021)
* Updated importmap and importmap-rails to 0.2.7
* Updated turbo-rails and stimulus-rails

### 2.3.3 (August 16th, 2021)
* Pinned importmap-rails to 0.2.2 as a temporary workaround

### 2.3.2 (August 16th, 2021)
* Updated to new importmap API

### 2.3.1 (August 13th, 2021)
* Fixed bug `not present in the asset pipeline` in production

### 2.3.0 (August 12th, 2021)
* Added an API!
* Added transliterations for non-latin characters in URLs
* Updated Stimulus + Turbo
* Updated importmap to use the importmap-rails gem
* Updated Russian locales
* Fixed overflow CSS-bug in media folders
* Fixed focus CSS-bug in Chrome
* Removed old importmap helpers

# 2.2

### 2.2.0 (July 26th, 2021)
* Added download link to attachments in media library
* Added optional decorator loading to configuration
* Fixed slug generation for non-latin characters
* Refactored authentication as a replaceable module

## 2.1

### 2.1.1 (July 13th, 2021)
* Fixed bugs with attachments (#746 / #747)
* Updated Spanish locales
* Updated German locales

### 2.1.0 (July 3rd, 2021)
* Refactored all javascript with Hotwire
* Refactored all CSS with TailwindCSS
* Refactored all views with ViewComponent
* Added importmap helper `spina_importmap_from`
* Added background job to save resource pages in bulk
* Added support for hotkeys
* Added sticky toolbar to Trix
* Fixed ActiveStorage variant definitions

## 2.0

⚠️ _Beware: lots of changes regarding page content. The old page parts are gone in favor of new JSON-based parts. Read the [Upgrading Guide](https://www.spinacms.com/docs/getting-started/upgrading) to learn how to upgrade._

### 2.0.2 (March 19th, 2021)
* Fixed issue with webp images

### 2.0.1 (March 18th, 2021)
* Fixed issue with sorting repeater parts

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