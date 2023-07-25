# Custom pages

You can define custom pages for your theme that will be generated when bootstrapping your website.
You can define whether or not they're deletable. By default Spina creates a custom page named Homepage which is not deletable.
You can define nested pages by passing the name of a custom page as the parent.

You define custom pages in your theme's config file:

```
::Spina::Theme.register do |theme|
  # ...

  theme.custom_pages = [
    {
      name: "homepage",
      title: "Homepage",
      deletable: false,
      view_template: "homepage"
    },
    {
      name: "articles",
      title: "Articles",
      deletable: false,
      view_template: "articles",
      parent: "homepage"
    }
  ]

  # ...
end
```