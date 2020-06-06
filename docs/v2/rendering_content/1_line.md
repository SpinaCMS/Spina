# Line

The most basic of all the parts, a simple textfield to store a line of text. 

Use the `content` helper method to render lines.

## Theme configuration

```
config.parts = [
  # ...
  {
    name: "headline",
    title: "Headline",
    part_type: "Spina::Parts::Line"
  }
]
```

## View template example
```
<h1><%= content(:headline) %></h1>
```
