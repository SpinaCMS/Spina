# Layout parts

Just like adding parts to view_templates you can also add parts you want to use globally throughout your website. These are called `layout_parts` and you can set them up like this:

```ruby
::Spina::Theme.register do |theme|
  theme.parts = [{
    name:       'footer',
    title:      'Footer',
    part_type:  'Spina::Parts::Text'
  }]
  # ...
  theme.layout_parts = %w(footer)
end
```

This content is stored on the `Spina::Account` model. You can use `current_spina_account.content` to render layout parts in your frontend.