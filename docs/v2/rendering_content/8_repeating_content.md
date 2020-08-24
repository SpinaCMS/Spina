# Repeating content

Nesting content is a very powerful feature of Spina. In your theme config you can configure repeating content by adding a part to `config.parts`. You can nest any parts you want, even custom parts.

## Theme configuration

```
config.parts = [
  # ...
  { name: "title", title: "Title", part_type: "Spina::Parts::Line" }, 
  { name: "image", title: "Image", part_type: "Spina::Parts::Image" }, 
  {
    name: "portfolio",
    title: "Portfolio",
    parts: %w(title image),
    part_type: "Spina::Parts::Repeater"
  }
]
```

## View template example

```
<% repeater(:portfolio) do |project| %>
  
  <h1><%= project.content(:title) %></h1>
  <%= project.content.image_tag(:image, resize: "400x300") %>

<% end %>
```