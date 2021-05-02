# Theme configuration file
# ========================
# This file is used for all theme configuration.
# It's where you define everything that's editable in Spina CMS.

Spina::Theme.register do |theme|
  # All views are namespaced based on the theme's name
  theme.name = 'demo'
  theme.title = 'Demo theme'

  # Parts 
  # Define all editable parts you want to use in your view templates
  # 
  # Built-in part types:
  # - Line
  # - MultiLine
  # - Text (Rich text editor)
  # - Image
  # - ImageCollection
  # - Attachment
  # - Option
  # - Repeater
  theme.parts = [
    {name: 'repeater', title: "Repeater", part_type: "Spina::Parts::Repeater", parts: %w(line image headline)}, 
    {name: 'line', title: "Line", part_type: "Spina::Parts::Line"}, 
    {name: 'body', title: "Body", part_type: "Spina::Parts::Text"}, 
    {name: "image_collection", title: "Image collection", part_type: "Spina::Parts::ImageCollection"}
    {name: 'image', title: "Image", part_type: "Spina::Parts::Image"}, 
    {name: 'headline', title: "Headline", part_type: "Spina::Parts::Line"}, 
    {name: 'footer', title: "Footer", part_type: "Spina::Parts::Text"}
  ]

  # View templates
  # Every page has a view template stored in app/views/my_theme/pages/*
  # You define which parts you want to enable for every view template
  # by referencing them from the theme.parts configuration above.
  theme.view_templates = [
    {name: 'homepage', title: 'Homepage', parts: %w(headline body image_collection)}, 
    {name: 'show', title: 'Default', parts: %w(body image repeater)}, 
    {name: 'demo', title: 'Demo', parts: %w(body image_collection image repeater)}
  ]

  # Custom pages
  # Some pages should not be created by the user, but generated automatically.
  # By naming them you can reference them in your code.
  theme.custom_pages = [
    {name: 'homepage', title: 'Homepage', deletable: false, view_template: 'homepage'}, 
    {name: 'demo', title: 'Demo', deletable: true, view_template: 'demo'}
  ]
  
  # Navigations (optional)
  # If your project has multiple navigations, it can be useful to configure multiple
  # navigations.
  theme.navigations = [
    {name: 'main', label: 'Main navigation'}
  ]
  
  # Layout parts (optional)
  # You can create global content that doesn't belong to one specific page. We call these layout parts.
  # You only have to reference the name of the parts you want to have here.
  theme.layout_parts = []
  
  # Resources (optional)
  # Think of resources as a collection of pages. They are managed separately in Spina
  # allowing you to separate these pages from the 'main' collection of pages.
  theme.resources = [
    {name: 'articles', label: "Articles", view_template: "article", slug: "articles"}
  ]

  # Plugins (optional)
  theme.plugins = ['reviews']
end
