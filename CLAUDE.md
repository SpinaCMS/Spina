# Spina CMS Development Guide

## Build & Test Commands
- Run all tests: `rake test`
- Run single test file: `ruby -I test test/path/to/file_test.rb`
- Run specific test: `ruby -I test test/path/to/file_test.rb -n test_method_name`
- Generate Tailwind CSS: `rake tailwindcss:build`
- Watch Tailwind for changes: `rake tailwindcss:watch`

## Code Style Guidelines
- **Ruby Version**: 2.7.0+ required
- **Framework**: Rails 6.0+ (supports up to Rails 8)
- **Testing**: Uses Minitest (not RSpec)
- **Naming**: Follow Rails conventions for controllers, models, and views
- **Translations**: Keep all user-facing text in locale files (/config/locales/)
- **Components**: Use ViewComponent for UI components
- **Error Handling**: Use Rails standard raise/rescue pattern
- **Part Classes**: When creating new part types, subclass from Spina::Parts::Base
- **Database**: PostgreSQL required for production

## Asset Organization
- JavaScript assets use importmaps (no webpack)
- Tailwind CSS for styling
- Place SVG icons in app/assets/icons/