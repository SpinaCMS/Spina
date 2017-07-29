::Spina::Theme.register do |theme|

  theme.name = 'demo'
  theme.title = 'Demo theme'

  theme.page_parts = [{
    name:           'line',
    title:          'Line',
    partable_type:  'Spina::Line'
  }, {
    name:           'text',
    title:          'Text',
    partable_type:  'Spina::Text'
  }, {
    name:           'photo',
    title:          'Photo',
    partable_type:  'Spina::Photo'
  }, {
    name:           'photo_collection',
    title:          'Photo collection',
    partable_type:  'Spina::PhotoCollection'
  }, {
    name:           'attachment',
    title:          'Attachment',
    partable_type:  'Spina::Attachment'
  }, {
    name:           'attachment_collection',
    title:          'Attachment collection',
    partable_type:  'Spina::AttachmentCollection'
  }, {
    name:           'structure',
    title:          'Structure',
    partable_type:  'Spina::Structure'
  }, {
    name:           'option',
    title:          'Option',
    partable_type:  'Spina::Option',
    options: {
      values: ['val1', 'val2']
    }
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
      name:           'alignment',
      title:          'Alignment',
      partable_type:  'Spina::Option',
      options: {
        values: ['left', 'right', 'center']
      }
    }]
  }]

  theme.layout_parts = [{
    name:           'line',
    title:          'Line',
    partable_type:  'Spina::Line'
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: ['text'],
  }, {
    name: 'show',
    title: 'Default',
    usage: 'Use for your content',
    page_parts: ['text']
  }, {
    name: 'demo',
    title: 'Demo',
    description: 'Contains examples of every page part',
    page_parts: ['line', 'text', 'photo', 'photo_collection', 'attachment', 'attachment_collection', 'option', 'structure']
  }]

  theme.custom_pages = [{
    name:           'homepage',
    title:          'Homepage',
    deletable:      false,
    view_template:  'homepage'
  }, {
    name:           'demo',
    title:          'Demo',
    deletable:      true,
    view_template:  'demo'
  }]

end
