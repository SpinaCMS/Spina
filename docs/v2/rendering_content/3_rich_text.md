# Rich text

Most pages include some sort of rich page content that you want to markup using text formatting. SpinaCMS uses [Trix](https://trix-editor.org) as it's default editor.

This part returns HTML. You can use the following helper to render it as HTML:

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "main_content",
    title: "Main content",
    part_type: "Spina::Parts::Text"
  }
]
```

## View template example
```
<%= content.html(:main_content) %>
```

## Embeddable content

Spina features a way to add embeddable components to Trix. It includes three components by default:
- Youtube
- Vimeo
- Button

You can enable these components by setting them in your theme initializer:
```
# config/initializers/themes/default.rb
Spina::Theme.register do |theme|
  # ...
  config.embeds = %w(button youtube vimeo)
  # ...
end
```

You can change the way these components are rendered by overriding these view templates:

```
# app/views/spina/embeds/buttons/_button.html.erb
<%= link_to button.url do %>
  <%= button.label %>
<% end %>
```

```
# app/views/spina/embeds/youtubes/_youtube.html.erb
<iframe id="ytplayer" type="text/html" width="640" height="360" src="https://www.youtube.com/embed/<%= youtube.id %>" frameborder="0"></iframe>
```

```
# app/views/spina/embeds/vimeos/_vimeo.html.erb
<iframe src="https://player.vimeo.com/video/<%= vimeo.id %>" width="640" height="475" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
```

## Creating your own embeddable component

It's easy to add custom embeddable components to Spina. Just create a new object that extends from `Spina::Embeds::Base` and add some attributes you'd like to store. All attributes are serialized to JSON and stored directly in HTML.

```
# app/models/spina/embeds/my_component.rb
module Spina::Embeds
  class MyComponent < Base
    attributes :some_attribute, :another_attribute
    
    # Use the heroicon method to choose an icon for Spina's UI
    heroicon "bookmark"
    
    # You can use regular Rails validations
    validates :some_attribute, presence: true
  end
end
```

Add some views for editing and rendering:

```
# app/views/spina/embeds/my_components/_my_component_fields.html.erb
<div class="text-xl font-bold mb-3 text-gray-800">
  My Component
  <div class="text-sm text-gray-500 font-normal">
    Embed my custom component
  </div>
</div>

<%= render Spina::Forms::LabelComponent.new(f, :some_attribute) %>
<%= render Spina::Forms::TextFieldComponent.new(f, :some_attribute, autofocus: true) %>

<%= render Spina::Forms::LabelComponent.new(f, :another_attribute) %>
<%= render Spina::Forms::TextFieldComponent.new(f, :another_attribute, autofocus: true) %>
```

```
# app/views/spina/embeds/my_components/_my_component.html.erb
<%= my_component.some_attribute %>
<%= my_component.another_attribute %>
```
