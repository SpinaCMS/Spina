# Rich text

Most pages include some sort of rich page content that you want to markup using text formatting. SpinaCMS uses [Trix](https://trix-editor.org) as it's default editor.

This part returns HTML. You can use the following helper to render it as HTML:

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "main_content",
    title: "Main content",
    part_type: "Spina::Parts::Text"
  }
]
```

## View template example
```
<%= content.html(:main_content) %>
```