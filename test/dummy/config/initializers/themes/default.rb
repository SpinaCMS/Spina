# frozen_string_literal: true

Spina::Theme.register do |theme|
  theme.name = "default"
  theme.title = "Default Theme"

  theme.custom_pages = [{
    name: "homepage",
    title: "Homepage",
    deletable: false,
    view_template: "homepage"
  }]

  theme.navigations = [{
    name: "mobile",
    label: "Mobile"
  }, {
    name: "main",
    label: "Main navigation"
  }]
end
