::Spina::Theme.register do |theme|

  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.page_parts = [{
    name:           'text',
    title:          'Text',
    partable_type:  'Spina::Text'
  }, {
    name: 'image',
    title: 'Image',
    partable_type: 'Spina::Image'  
  }, {
    name: 'image_collection',
    title: 'Image collection',
    partable_type: 'Spina::ImageCollection'
  }]

  theme.view_templates = [{
    name:       'homepage',
    title:      'Homepage',
    page_parts: ['text']
  }, {
    name: 'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    page_parts:   ['image', 'image_collection', 'text']
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
