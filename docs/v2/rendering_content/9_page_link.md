# PageLink

An PageLink is a part where you can link to another page. You can optionally scope it to a resource.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "page",
    title: "Page",
    part_type: "Spina::Parts::PageLink"
  }
]
```

```
config.parts = [
  # ...
  {
    name: "blogpost",
    title: "Blogpost",
    part_type: "Spina::Parts::PageLink",
    options: {
      resource: "blog"
    }
  }
]
```
