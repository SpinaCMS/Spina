# Page parts

A page in Spina has many Page parts. By default these page parts can be one of the following:
- Spina::Line
- Spina::Text
- Spina::Image
- Spina::ImageCollection
- Spina::Structure
- Spina::Option
These are the building blocks of your view templates. You can have an unlimited number of page parts in a page. We prefer to keep the number of parts to a minimum so that managing your pages won't become too complex.

Spina uses an initializer to create the basic building blocks of your page. There are three steps to add a new building block or page part to your app:
Set up a new page part in the initializer
Set the new initializer into a view template
Add it to the view
*Create a new page part*
When you install Spina, you will see the following in config/initializers/themes/default.rb

```
::Spina::Theme.register do |theme|
  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.page_parts = [{
    name:             'content',
    title:            'Content',
    partable_type:    'Spina::Text'
  }]

  theme.view_templates = [{
    name:       'homepage',
    title:      'Homepage',
    page_parts: ['content']
  }, {
    name: 'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    page_parts:   ['content']
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

Spina represents each building block of your page, called a 'page part,' as a hash inside the page_parts array. If we look at the default setup we can see there is one hash inside the array representing the one textbox we see on our page.

Let's say I wanted to add another text box below this called portfolio. First I would add another hash to the self.page_parts array like so:

```
theme.page_parts = [{
  name:             'content',
  title:            'Content',
  partable_type:    'Spina::Text'
}, {
  name:             'portfolio', # added this hash
  title:            'Portfolio',
  partable_type:    'Spina::Text'
}]
```

*Add it to the view template*
Now, we need to update the self.view_templates hash next. These view templates provide customization for the different views you might want. For example, you may have a 'blog' view or an 'about' view which add different page parts. For this example we will add the portfolio part into the 'Default' view template.

```
theme.view_templates = [{
  name:       'homepage',
  title:      'Homepage',
  page_parts: ['content']
}, {
  name:         'show',
  title:        'Default',
  description:  'A simple page',
  usage:        'Use for your content',
  page_parts:   ['content', 'portfolio'] # added 'portfolio'
}]
```

*Add it to the view*
Finally, let's go to views/default/pages/show.html.erb and add the following:

```
<h1><%= @page.title %></h1>

<%= @page.content(:text).try(:html_safe) %>
<%= @page.content(:portfolio).try(:html_safe) %> # added this line
```

We have successfully added another textbox! Restart your server and load up the admin section again. You should see another text box below the content box.