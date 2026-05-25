# Layout parts

Layout parts are editable content that belongs to your website as a whole, rather than to a single page. This content is stored on the `Spina::Account` model and can be rendered with `current_spina_account.content`.

Define layout parts in `app/templates/spina/your_theme/layout.rb`:

```ruby
# app/templates/spina/default/layout.rb
LayoutParts.define do
  part :footer, :text, title: "Footer"
  part :tag_line, :line
end
```

Spina automatically sets `theme.layout_parts` from the parts defined in this file.

## Rendering layout parts

```erb
<%= current_spina_account.content.html :footer %>
```

If you need a part to appear on the layout but not on any page type, define it only in `layout.rb`.
