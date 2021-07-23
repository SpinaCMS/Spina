# Attachment

You can upload any file as an attachment using ActiveStorage. Use the `content.attachment_url` helper to render the URL.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "file",
    title: "File",
    part_type: "Spina::Parts::Attachment"
  }
]
```

```
<%= content.attachment_url(:file) %>
```
