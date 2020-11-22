# Datetime

The datetime part allows you to select a date and time using the [Flatpickr](https://flatpickr.js.org/) date picker library.
This comes useful when you want to allow your users to pick a publication date, or enter a date for whatever other reasons.

## Theme configuration

The most basic configuration.

```
config.parts = [
  # ...
  {
    name: "datetime",
    title: "Datetime",
    part_type: "Spina::Parts::Datetime"
  }
]
```

You can also configure the part using the config options provided by [Flatpickr](https://flatpickr.js.org/).

```
config.parts = [
  # ...
  {
    name: "datetime",
    title: "Datetime",
    options: {
      locale: 'es',
      enable_time: true
    },
    part_type: "Spina::Parts::Datetime"
  }
]
```

See [Flatpickr Config](https://flatpickr.js.org/options/) for more config options.


## View template example
```
<p><%= <%= content.datetime(:datetime) %></p>

# you can format it yourself
<p><%= <%= content.datetime(:datetime, '%B %d, %Y') %></p>

# or you can use Time::DATE_FORMATS symbols
<p><%= <%= content.datetime(:datetime, :long) %></p>
```
