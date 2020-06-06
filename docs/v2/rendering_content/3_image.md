# Image

SpinaCMS uses ActiveStorage to handle image uploads and variants. Make sure you've installed ActiveStorage in your Rails app before using `Spina::Parts::Image`.

You can render images in two ways: 
- using an image_tag
- using a URL

## Image tag example

```
<%= content.image(:part_name, {resize: '200x200'}, {class: 'image'}) %>
```

This `content` helper will automatically add an `alt` attribute to the image. You can change the alt text when editing pages in Spina.

## Image URL example

```
<div style="background-image: url(<%= content.image_url(:part_name, {resize: '1280x200'}) %>)"></div>
```
