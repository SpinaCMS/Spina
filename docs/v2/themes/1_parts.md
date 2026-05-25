# Parts

A page in Spina has many parts. By default these parts can be one of the following:

- Spina::Parts::Line
- Spina::Parts::MultiLine
- Spina::Parts::Text
- Spina::Parts::Image
- Spina::Parts::ImageCollection
- Spina::Parts::Repeater
- Spina::Parts::Option

These are the building blocks of your view templates. You can have an unlimited number of parts in a page. We prefer to keep the number of parts to a minimum so that managing your pages isn't too complex.

Parts are defined in page template files under `app/templates/spina/your_theme/`. There are three steps to add a new part to your app:

- Define the part in a page template file
- Add it to the view

## Theme configuration

Your theme initializer only contains global theme settings:

```ruby
# config/initializers/themes/default.rb
Spina::Theme.register do |theme|
  theme.name = "default"
  theme.title = "Default theme"

  theme.custom_pages = [
    {name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"}
  ]

  theme.navigations = [
    {name: "main", label: "Main navigation"}
  ]

  theme.embeds = []
end
```

Page templates are loaded automatically from `app/templates/spina/default/`.

## Create a new page part

When you install Spina, you will see page template files like this:

```ruby
# app/templates/spina/default/show.rb
PageTemplate.define :show do
  title "Page"
  part :text, :text, title: "Body", hint: "Your main content"
end
```

Built-in part types can be referenced as symbols (`:line`, `:text`, `:image`, and so on). Custom or extension parts use the full class name as a string:

```ruby
part :case_study, "MyApp::Parts::CaseStudy"
```

Let's say you wanted to add another text box below the body called portfolio. Update the page template:

```ruby
# app/templates/spina/default/show.rb
PageTemplate.define :show do
  title "Page"
  part :text, :text, title: "Body", hint: "Your main content"
  part :portfolio, :text, title: "Portfolio"
end
```

## Add it to the view

Finally, go to `app/views/default/pages/show.html.erb` and add:

```erb
<h1><%= current_page.title %></h1>

<%= content.html :text %>
<%= content.html :portfolio %>
```

Refresh the page form in the admin section. You should see another text box below the content box.

## Migrating from the old configuration style

Previously, all parts were defined in the theme initializer using `theme.parts` and `theme.view_templates`. That style still works, but is deprecated and will be removed in a future major version of Spina.

To migrate an existing theme automatically:

```bash
bin/rails spina:theme:migrate_templates[default]
```

This generates page template files, creates `layout.rb` if needed, and replaces your theme initializer with a slim version. Your original file is backed up to `config/initializers/themes/default.rb.bak`.
