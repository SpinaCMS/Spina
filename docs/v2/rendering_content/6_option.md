# Option

An option is simply a `select` with a predefined list of options that the end user can choose between. You can render it just like you would render a line.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "alignment",
    title: "Alignment",
    options: ["left", "right", "center"],
    part_type: "Spina::Parts::Option"
  }
]
```

## View template example

```
<%= content(:alignment) %>
``` 
