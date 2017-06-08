# Page parts

There are several code building blocks that can be used to create content in
Spina.

- `Spina::Line`
- `Spina::Text`
- `Spina::Photo`
- `Spina::PhotoCollection`
- `Spina::Structure`
- `Spina::Option`

## `Spina::Line`

This is a single line of text. To add one to your template:

    ::Spina::Theme.register do |theme|

      theme.name = 'default'
      theme.title = 'Default Theme'

      theme.page_parts = [{
        name:           'text',
        title:          'Text',
        partable_type:  'Spina::Text'
      }]

      theme.view_templates = [{
          name:       'banner_page',
          title:      'Banner Page',
          page_parts: ['text']
        }
      # other stuff...

    end

You can now edit this line as the field `Text` for page types `Banner Page`.

To consume this in your view template:

    = @page.content(:text).try(:html_safe)

## `Spina::Text`

**TBC**

## `Spina::Photo`

**TBC**

## `Spina::PhotoCollection`

**TBC**

## `Spina::Structure`

**TBC**

## `Spina::Option`

The `Spina::Option` type allows you to specify a pick-list of options. For example,
to add a page part that permits the editor to select between Red, Green and Blue:

    ::Spina::Theme.register do |theme|

      theme.name = 'default'
      theme.title = 'Default Theme'

      theme.page_parts = [{
        name:           'colour',
        title:          'Colour',
        partable_type:  'Spina::Option',
        options: {
          values: ['Red', 'Green', 'Blue']
        }
      ]

      theme.view_templates = [{
          name:       'bright_page',
          title:      'Bright Page',
          page_parts: ['colour']
        }
      # other stuff...

    end

And then to use this you'll need to add translations for each option in your locales file:

    en:
      options:
        colour:
          Green: 'Green'
          Red: 'Red'
          Blue: 'Blue'

Then in the template:

    = @page.content(:colour)

## `Spina::Link`

The `Spina::Link` type allows you to create a simple link to another page on the site.

    ::Spina::Theme.register do |theme|

      theme.name = 'default'
      theme.title = 'Default Theme'

      theme.page_parts = [{
        name:           'link',
        title:          'Link',
        partable_type:  'Spina::Link',
      ]

      theme.view_templates = [{
          name:       'link_page',
          title:      'Link Page',
          page_parts: ['link']
        }
      # other stuff...

    end

In the admin interface, you will now be able to pick from published pages, and add a link title.
To consume in you templates:

    = link_to @page.content(:link).title, @page.content(:link).materialized_path
