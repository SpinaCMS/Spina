::Spina::Theme.register do |theme|

  theme.name = 'demo'
  theme.title = 'Demo theme'

  theme.structures = [{
    name: 'faq',
    parts: ['title:line', 'description:text']
  }]

  theme.view_templates = [{
    name: 'homepage',
    parts: ['description:text']
  }, {
    name: 'show',
    parts: ['text:text']
  }, {
    name: 'demo',
    parts: ['heading:line', 'description:text', 'header_image:image', 'faq:structure']
  }]

  theme.custom_pages = [{
    name:           'homepage',
    deletable:      false,
    view_template:  'homepage'
  }, {
    name:           'demo',
    deletable:      true,
    view_template:  'demo'
  }]

end
