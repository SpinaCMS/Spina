# SVG Files in Spina

Files with the `imge/svg+xml` content type can be used as XSS vectors. As such, [Rails by default forces their `Content-Disposition` header to `attachment`](https://github.com/rails/rails/issues/34665#issuecomment-445888009). If you wish to use SVG images in `<img>` tags, you will need to remove the content type for the sanitizer.

You can use the [following code](https://github.com/Dreamersoul/administrate-field-active_storage/issues/36#issuecomment-608446819) in an initializer to achieve this:

```ruby
# Warning: Make sure to sanitize SVGs if users gain the ability to upload themselves:
# https://github.com/rails/rails/issues/34665#issuecomment-446601748
Rails.application.config.active_storage.content_types_to_serve_as_binary.delete("image/svg+xml")
```

Additionally, and particularly if you intend to let users upload their own SVG content, add the [`active_storage_svg_sanitizer` gem](https://github.com/hopsoft/active_storage_svg_sanitizer/) to your `Gemfile`:

```
gem 'active_storage_svg_sanitizer'
```
