![Spina CMS](http://www.denkwebsite.nl/spinacms.png)

[Visit the website](http://www.spinacms.com)

[![Code Climate](https://codeclimate.com/github/denkGroot/Spina/badges/gpa.svg)](https://codeclimate.com/github/denkGroot/Spina)
[![Test Coverage](https://codeclimate.com/github/denkGroot/Spina/badges/coverage.svg)](https://codeclimate.com/github/denkGroot/Spina/coverage)
[![Codeship Status for denkGroot/Spina](https://img.shields.io/codeship/e13debf0-e6af-0132-8abf-32d84f3372de.svg)](https://codeship.com/projects/82322)
[![Slack](https://slack-spina-cms.herokuapp.com/badge.svg)](https://slack-spina-cms.herokuapp.com)

# Getting Started

Spina is a CMS built upon the Rails framework. This guide is designed for developers with experience using Ruby on Rails.

To start using Spina CMS simply add the following lines to your Gemfile:

```ruby
gem 'spina-template'
gem 'spina'
```

Make sure you run the installer to get started.

    rails g spina:install

The installer will help you setup your first user.

Then start `rails s` and access your admin panel at `/admin`.

# Basics

The installer generates a few initializers that contain necessary configuration for Spina.

Please see the [wiki](https://github.com/Shinetechchina/Spina/wiki/Documents-for-theme-configuraion) to know more about how Spina configuration file works.

In the initializers folder there's a new folder named `themes`. Inside you will find a configuration file named `default.rb`. This file contains all of your theme-specific settings. You can define multiple Page parts, Layout parts, View templates and Custom pages.

## Page parts

A page in Spina has many Page parts. By default these page parts can be one of the following:

- `Spina::Line`
- `Spina::Text`
- `Spina::Photo`
- `Spina::PhotoCollection`
- `Spina::Color`
- `Spina::Structure`

These are the building blocks of your view templates. You can have an unlimited number of page parts in a page. We prefer to keep the number of parts to a minimum so that managing your pages won't become too complex.

Spina uses an initializer to create the basic building blocks of your page. There are three steps to add a new building block or page part to your app:

1. Set up a new page part in the initializer
2. Set the new initializer into a view template
3. Add it to the view

#### Create a new page part
When you install Spina, you will see the following in `config/initializers/themes/default.rb`

```ruby
module Spina
  module DefaultTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = "Default theme"

    self.page_parts = [{
      name: 'content',
      title: 'Content',
      page_partable_type: "Spina::Text"
    }]

    self.structures = []
    self.layout_parts = []
    self.custom_pages = []
    self.plugins = []

    self.view_templates = {
      'homepage' => {
        title: 'Homepage',
        page_parts: ['content']
      },
      'show' => {
        title: 'Default',
        description: 'A simple page',
        usage: 'Use for your content',
        page_parts: ['content']
      }
    }

    self.custom_pages = [
      { name: 'homepage', title: 'Homepage', deletable: false, view_template: 'homepage' }
    ]
  end
end
```

Right now, the default theme is applying a title to the page, with a simple text div below it. Go to `/admin` on your app and have a look. Edit the textbox and go to preview the page.

Spina represents each building block of your page, called a 'page part,' as a hash inside the `page_parts` array. If we look at the default setup we can see there is one hash inside the array representing the one textbox we see on our page.

Let's say I wanted to add another text box below this called `portfolio`. First I would add another hash to the `self.page_parts` array like so:

```ruby
self.page_parts = [
  { name: 'content', title: 'Content', page_partable_type: "Spina::Text" },
  { name: 'portfolio', title: 'Portfolio', page_partable_type: "Spina::Text" } # added this second hash
]
```

#### Add it to the view template

Now, we need to update the `self.view_templates` hash next. These view templates provide customization for the different views you might want. For example, you may have a 'blog' view or an 'about' view which add different page parts. For this example we will add the portfolio part into the 'Default' view template.

```ruby
self.view_templates = {
  'homepage' => {
    title: 'Homepage',
    page_parts: ['content']
  },
  'show' => {
    title: 'Default',
    description: 'A simple page',
    usage: 'Use for your content',
    page_parts: ['content', 'portfolio'] # added 'portfolio' here.
  }
}
```

#### Add it to the view

Finally, let's go to `views/default/pages/show.html.erb` and add the following:

```ruby
<h1><%= @page.title %></h1>

<%= @page.content(:content).try(:html_safe) %>
<%= @page.content(:portfolio).try(:html_safe) %> # added this line
```

We have successfully added another textbox! Restart your server and load up the admin section again. You should see another text box below the content box.

## Layout parts

Sometimes you need editable content that's not specific to a view template but to your theme as a whole. You can use the following parts in your layout.

- `Spina::Line`
- `Spina::Color`

## View templates

Each theme typically has a few different view templates which make up your website. By default Spina generates a *homepage* and *show* template.

The views for these templates are stored in `app/views/default/pages`.

## Custom pages

You can define custom pages for your theme that will be generated when bootstrapping your website. You can define whether or not they're deletable. By default Spina creates a custom page named Homepage which is not deletable.

# License

Spina is released under the [MIT license](LICENSE.md).

# Credits

Some parts of Spina are heavily influenced by the wonderful Refinery CMS. Credits to [the Refinery  team](http://www.refinerycms.com/about).

All icons in Spina were made by Brent Jackson [Geomicons](http://jxnblk.com/geomicons-wired/).
