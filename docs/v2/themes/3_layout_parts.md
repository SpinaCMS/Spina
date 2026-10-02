# Layout parts

Layout parts are editable content that belongs to your website as a whole, rather than to a single page. This content is stored on the `Spina::Account` model and can be rendered with `current_spina_account.content`.

Define layout parts in `app/templates/spina/your_theme/layout.rb`:

```ruby
# app/templates/spina/default/layout.rb
Spina.define_layout_parts do
  part :footer, :text, title: "Footer"
  part :tag_line, :line
end
```

Spina automatically sets `theme.layout_parts` from the parts defined in this file.

## Sections

The Layout screen can split parts into tabs. Express that with `section` blocks:

```ruby
Spina.define_layout_parts do
  section :general do
    part :footer, :text
    part :logo, :image
  end

  section :seo do
    part :meta_title, :line
  end
end
```

Tab labels use `I18n` keys under `spina.layout.sections.<name>`. You cannot mix top-level parts with sections in the same file.

## Rendering layout parts

```erb
<%= current_spina_account.content.html :footer %>
```

If you need a part to appear on the layout but not on any page type, define it only in `layout.rb`.
