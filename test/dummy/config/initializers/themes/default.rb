::Spina::Theme.register do |theme|

  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.parts = [{
    name:       'text',
    title:      'Text',
    hint:       'Your main content',
    part_type:  'Spina::Parts::Text'
  }, {
    name: 'attachment',
    title: "Attachment",
    part_type: "Spina::Parts::Attachment"
  }]

  theme.view_templates = [{
    name:       'homepage',
    title:      'Homepage',
    parts:      ['text']
  }, {
    name:         'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    parts:        ['text', 'attachment']
  }]

  # ADDITION
  # set homepage to true
  theme.custom_pages = [{
    name:           'homepage',
    title:          'Homepage',
    deletable:      false,
    view_template:  'homepage',
    homepage:       true
  }]

  theme.navigations = [{
    name: 'mobile',
    label: 'Mobile'
  }, {
    name: 'main',
    label: 'Main navigation'
  }]

end
