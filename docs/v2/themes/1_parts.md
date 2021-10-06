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

Spina uses an initializer to create the basic building blocks of your page. There are three steps to add a new building block or part to your app:

- Set up a new part in the initializer
- Set the new initializer into a view template
- Add it to the view

**Create a new page part**

When you install Spina, you will see the following in config/initializers/themes/default.rb

```ruby
::Spina::Theme.register do |theme|
  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.parts = [{
    name:         'content',
    title:        'Content',
    part_type:    'Spina::Parts::Text'
  }]

  theme.view_templates = [{
    name:  'homepage',
    title: 'Homepage',
    parts: %w(content)
  }, {
    name: 'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    parts:        %w(content)
  }]

  theme.custom_pages = [{
    name:           'homepage',
    title:          'Homepage',
    deletable:      false,
    view_template:  'homepage'
  }]
end
```

Right now, the default theme is applying a title to the page, with a simple text div below it. Go to /admin on your app and have a look. Edit the textbox and go to preview the page.

Let's say I wanted to add another text box below this called portfolio. First I would add another hash to the parts array like so:

```ruby
theme.parts = [{
  name:         'content',
  title:        'Content',
  part_type:    'Spina::Parts::Text'
}, {
  name:         'portfolio', # added this part
  title:        'Portfolio',
  part_type:    'Spina::Parts::Text'
}]
```

**Add it to the view template**

Now, we need to update the view_templates config. These view templates provide customization for the different views you might want. For example, you may have a 'blog' view or an 'about' view which add different parts. For this example we will add the portfolio part into the 'Default' view template.

```ruby
theme.view_templates = [{
  name:  'homepage',
  title: 'Homepage',
  parts: %w(content)
}, {
  name:         'show',
  title:        'Default',
  description:  'A simple page',
  usage:        'Use for your content',
  parts:        %w(content portfolio) # added 'portfolio'
}]
```

**Add it to the view**

Finally, let's go to views/default/pages/show.html.erb and add the following:

```erb
<h1><%= current_page.title %></h1>

<%= content.html :text %>
<%= content.html :portfolio %> # added this line
```

We have successfully added another textbox! Refresh the page form in the admin section. You should see another text box below the content box.