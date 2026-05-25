# Themes

The installer generates a few initializers that contain necessary configuration for Spina.

In the initializers folder there's a new folder named themes. Inside you will find a configuration file named default.rb. This file contains your theme's global settings: custom pages, navigations, embeds, and so on.

Page and layout part definitions live in `app/templates/spina/default/`:

- `layout.rb` — global layout parts (`LayoutParts.define`)
- `homepage.rb`, `show.rb`, etc. — page type definitions (`PageTemplate.define`)

See [Parts](themes/1_parts.md), [View templates](themes/2_view_templates.md), and [Layout parts](themes/3_layout_parts.md) for details.
