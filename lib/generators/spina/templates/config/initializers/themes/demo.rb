page_parts = [{
  name:               'line',
  title:              'Line',
  page_partable_type: 'Spina::Line'
}, {
  name:               'text',
  title:              'Text',
  page_partable_type: 'Spina::Text'
}, {
  name:               'photo',
  title:              'Photo',
  page_partable_type: 'Spina::Photo'
}, {
  name:               'photo_collection',
  title:              'Photo collection',
  page_partable_type: 'Spina::PhotoCollection'
}, {
  name:               'attachment',
  title:              'Attachment',
  page_partable_type: 'Spina::Attachment'
}, {
  name:               'attachment_collection',
  title:              'Attachment collection',
  page_partable_type: 'Spina::AttachmentCollection'
}, {
  name:               'structure',
  title:              'Structure',
  page_partable_type: 'Spina::Structure'
}, {
  name:               'color',
  title:              'Color',
  page_partable_type: 'Spina::Color'
}]

structures = {
  'structure' => [{
    name:                     'title',
    title:                    'Title',
    structure_partable_type:  'Spina::Line'
  }, {
    name:                     'description',
    title:                    'Description',
    structure_partable_type:  'Spina::Text'
  }]
}

layout_parts = [{
  name:               'line',
  title:              'Line',
  layout_partable_type: 'Spina::Line'
}, {
  name:               'color',
  title:              'Color',
  layout_partable_type: 'Spina::Color'
}]

view_templates = {
  'homepage' => {
    title:      'Homepage',
    page_parts: ['text']
  },
  'show' => {
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    page_parts:   ['text']
  },
  'demo' => {
    title:      'Demo',
    description: 'Contains examples of every page part',
    page_parts: ['line', 'text', 'photo', 'photo_collection', 'attachment', 'attachment_collection', 'structure', 'color']
  }
}

custom_pages = [{
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

theme = Spina::Theme.new(
  name:           'demo',
  title:          'Demo theme',
  page_parts:     page_parts,
  structures:     structures,
  layout_parts:   layout_parts,
  view_templates: view_templates,
  custom_pages:   custom_pages,
  plugins:        ['reviews']
)
Spina::Theme.register(theme)
