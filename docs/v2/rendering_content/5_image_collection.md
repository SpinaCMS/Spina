# Image collection

A collection of images is automatically sorted and can be rendered by using the `images` helper and passing a block.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "cars",
    title: "Images of cars",
    part_type: "Spina::Parts::ImageCollection"
  }
]
```

## View template example

```
<% images(:cars) do |image| %>

  <%= content.image_tag image, resize_to_fill: [50, 50] %>

<% end %>
```
