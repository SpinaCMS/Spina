# Upgrading from v1

Already have a project on v1.0-v1.1? We've created a gem to make the upgrade process easier for you. 

## Changes in v2
The biggest change in v2 (and why this is v2 and not v1.2) is that all PageParts have been refactored and changed to ruby objects persisted as JSON, directly on the Page model. Spina uses the attr_json gem to serialize and deserialize page content. This has a couple of huge benefits: 

- Greatly reduces SQL-queries for a typical page
- Rendering pages is crazy fast, fragment caching not required
- Creating new parts is easy and doesn't require database migrations
- All parts can automatically be used as global "layout" parts
- All parts (including custom parts) support translations out of the box

## Steps to upgrade
Upgrading is straightforward, but may require some work. Especially if you're using a lot of custom page parts.

### 1. Update the gem
If you haven't already, update `spina` to the latest version.

### 2. Add the spina-upgrade gem
Add the `spina-upgrade` gem to your Gemfile.

### 3. Install & run migrations
Spina v2 comes with two migrations to add json_attributes to the Page and Account models. Run `rails spina:install:migrations` to copy them and run `rails db:migrate` to add them to your database.

### 4. Refactor custom pageparts to AttrJSON-backed parts
All PageParts that were previously included in Spina v1 were recreated as parts in the `Spina::Parts` namespace. The spina-upgrade gem includes the necessary code to convert the old models to these new JSON-backed parts. Here's an example of the Spina::Line part in spina-upgrade:

```ruby
module Spina
  class Line < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true

    def convert_to_json!
      text = Spina::Parts::Line.new
      text.content = content
      text
    end
  end
end
```

If you're using any custom PageParts that you'd like to migrate, create a new JSON-backed part for it and add a `convert_to_json!` method to your old custom PagePart.

### 5. Update your theme config

Change `config.page_parts` to `config.parts` and change all items to reflect the new changes.

Example:
```ruby
theme.parts = [{
  name: 'text',
  title: "Text",
  part_type: "Spina::Parts::Text"
}]
```

Delete `config.structures` and instead add structures as repeater parts like this:

```ruby
theme.parts = [
  # ...
  {
    name: 'portfolio',
    title: "Portfolio",
    part_type: "Spina::Parts::Repeater",
    parts: %w(title image description)
  }
]
```

Change `page_parts` to `parts` in your view_templates config

```ruby
theme.view_templates = [
  # ...
  {
    name: 'homepage',
    title: 'Homepage',
    parts: %w(headline body)
  }
]
```

### 6. Migrate your content to JSON

Run `rails spina:convert_page_parts_to_json` to migrate all of your content to JSON. This task will check if all of your content can be converted. If not, you can abort the migration or continue anyway.

### 7. Change content helpers

Spina v2 includes a lot of useful new content helpers which make your life easier. It's possible you need to edit your view templates to use these new content helpers.

You can still use the `content` helper to just render content like before. Here's a list of the most useful additions:

- `content.html(part_name)` - renders content as html_safe
- `content.image_tag(part_name)` - uses main_app to render image_tags using ActiveStorage, works like regular `image_tag` helper
- `repeater(part_name)` - pass it a block to render repeated content (like you would for structures in v1)