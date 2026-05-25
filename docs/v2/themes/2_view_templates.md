# View templates

Each theme typically has a few different view templates which make up your website. By default Spina generates a homepage and show template.

View templates are defined as Ruby files in `app/templates/spina/your_theme/`:

```ruby
# app/templates/spina/default/homepage.rb
PageTemplate.define :homepage do
  title "Homepage"
  description "The front page of your website"

  part :headline, :line
  part :body, :text
  part :hero_image, :image
end
```

The views for these templates are stored in `app/views/default/pages/`.

## Repeating content

Use a `repeater` block for nested content:

```ruby
PageTemplate.define :show do
  title "Page"

  repeater :portfolio do
    part :title, :line
    part :image, :image
    part :description, :text
  end
end
```

## Template metadata

You can set additional options on a page template:

```ruby
PageTemplate.define :blogpost do
  title "Blogpost"
  description "Article template"
  usage "Use for blog articles"
  exclude_from %w[main]
  layout "article"
end
```

## Custom template path

By default, Spina loads templates from `app/templates/spina/{theme.name}/`. You can override this in your theme initializer:

```ruby
theme.load_templates_from "app/templates/spina/default"
```
