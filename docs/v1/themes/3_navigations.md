# Navigations

Usually managing a single list of pages is enough for most use cases. Sometimes however, you need a little more flexibility. This is where navigations come in. You can create multiple navigations which are basically different collections of your pages. You can choose to include all or just a few of your pages. You can also edit the order of pages per navigation.

You define navigations in your theme's config file:

```
::Spina::Theme.register do |theme|
  # ...

  theme.navigations = [{
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }, {
    name: 'mobile',
    label: 'Mobile'  
  }]

  # ...
end
```

auto_add_pages ensures that each page that you create automatically gets added to this navigation.

Besides navigations there's always a single overview of all pages. Your sitemap and friendly URLs are generated based on this overview.

Creating navigations is optional.