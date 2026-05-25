# frozen_string_literal: true

Spina::Theme.register do |theme|
  theme.name = "demo"
  theme.title = "Demo theme"

  theme.custom_pages = [
    {name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"},
    {name: "demo", title: "Demo", deletable: true, view_template: "demo"}
  ]

  theme.navigations = [
    {name: "main", label: "Main navigation"}
  ]

  theme.resources = [
    {name: "articles", label: "Articles", view_template: "article", slug: "articles"}
  ]

  theme.plugins = ["reviews"]
end
