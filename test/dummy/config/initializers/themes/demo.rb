::Spina::Theme.register do |theme|

  theme.name = 'demo'
  theme.title = 'Demo theme'

  # All available parts
  theme.parts = [{
    name: 'repeater',
    title: "Repeater",
    part_type: "Spina::Parts::Repeater",
    parts: ['line', 'body', 'image']
  }, {
    name: 'repeater2',
    title: "Repeater",
    part_type: "Spina::Parts::Repeater",
    parts: ['line', 'image']
  }, {
    name: 'line',
    title: "Line",
    part_type: "Spina::Parts::Line"
  }, {
    name: 'body',
    title: "Body",
    part_type: "Spina::Parts::Text"
  }, {
    name: "image_collection",
    title: "Image collection",
    part_type: "Spina::Parts::ImageCollection"
  }, {
    name: 'image',
    title: "Image",
    part_type: "Spina::Parts::Image"
  }, {
    name: 'headline',
    title: "Headline",
    part_type: "Spina::Parts::Line"
  }, {
    name: 'footer',
    title: "Footer",
    part_type: "Spina::Parts::Text"
  }, {
    name: 'option',
    title: "Option",
    part_type: "Spina::Parts::Option",
    options: [["Left", 'left'], ["Center", 'center'], ["Right", 'right']]
  }, {
    name: 'attachment',
    title: "Attachment",
    part_type: "Spina::Parts::Attachment"
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: [],
    parts: ['headline', 'body', 'image_collection']
  }, {
    name: 'show',
    title: 'Default',
    usage: 'Use for your content',
    page_parts: [],
    parts: ['attachment', 'option', 'body', 'image', 'repeater']
  }, {
    name: 'demo',
    title: 'Demo',
    description: 'Contains examples of every page part',
    page_parts: [],
    parts: ['repeater', 'repeater2', 'attachment', 'option', 'body', 'image_collection', 'image']
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

  # Some global content
  theme.layout_parts = ['line', 'body', 'repeater']

  theme.plugins = ['reviews']

end
