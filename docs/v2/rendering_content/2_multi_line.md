# MultiLine

Similar to the Line part, however instead of a simple textfield, it uses a textarea to store a multiple lines of text.

Use the `content` helper method to render lines. You may also want to use `simple_format` so that break lines are respected.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "teaser",
    title: "Teaser",
    part_type: "Spina::Parts::MultiLine"
  }
]
```

## View template example
```
<p><%= simple_format content(:teaser) %></p>
```
