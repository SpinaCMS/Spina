::Spina::Theme.register do |theme|

  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.parts = [{
    name: 'text',
    title: "Text",
    part_type: "Spina::Parts::Text"
  }]

  theme.view_templates = [{
    name:       'homepage',
    title:      'Homepage',
    parts: ['text']
  }, {
    name: 'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    parts:   ['text']
  }]

  theme.custom_pages = [{
    name:           'homepage',
    title:          'Homepage',
    deletable:      false,
    view_template:  'homepage'
  }]

  theme.navigations = [{
    name: 'mobile',
    label: 'Mobile'
  }, {
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }]

end
