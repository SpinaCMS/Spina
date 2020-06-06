# Rich text

Most pages include some sort of rich page content that you want to markup using text formatting. SpinaCMS uses [Trix](https://trix-editor.org) as it's default editor.

Class name: `Spina::Parts::Text`. This part returns HTML. You can use the following helper to render it as HTML:

```
<%= content.html(:part_name) %>
```