# Image collection

A collection of images is automatically sorted and can be rendered by using the `images` helper and passing a block.

```
<% images(:image_collection) do |image| %>

  <%= content.image_tag image, resize: '50x50' %>

<% end %>
```
