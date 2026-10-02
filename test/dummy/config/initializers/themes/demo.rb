# frozen_string_literal: true

Spina::Theme.register do |theme|
  theme.name = "demo"
  theme.title = "Demo theme"

  theme.resources = [
    {name: "landing_pages", label: "Landing pages"},
    {name: "blog", label: "Blog"}
  ]

  theme.custom_pages = [
    {name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"},
    {name: "demo", title: "Demo", deletable: true, view_template: "demo"}
  ]

  theme.plugins = ["reviews"]
  theme.embeds = %w[button youtube vimeo]
end
