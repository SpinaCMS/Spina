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
  }, {
    name: 'line',
    title: 'Line',
    partable_type: 'Spina::Line'  
  }, {
    name: 'structure',
    title: "Structure",
    partable_type: "Spina::Structure"
  }, {
    name: 'attachment',
    title: "Attachment",
    partable_type: "Spina::Attachment"
  }]

  theme.structures = [{
    name: 'structure',
    structure_parts: [{
      name:           'title',
      title:          'Title',
      partable_type:  'Spina::Line'
    }, {
      name:           'description',
      title:          'Description',
      partable_type:  'Spina::Text'
    }, {
      name: 'photo',
      title: 'Photo',
      partable_type: 'Spina::Image'
    }]
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
    page_parts:   ['image', 'image_collection', 'text', 'line', 'structure', 'attachment']
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
