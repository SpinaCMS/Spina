::Spina::Theme.register do |theme|

  theme.name = 'demo'
  theme.title = 'Demo theme'

  theme.layout_parts = ['line', 'body']

  # New config
  theme.parts = [{
    name: 'repeater',
    title: "Repeater",
    part_type: "Spina::Parts::Repeater",
    parts: ['line', 'image', 'headline', 'image_collection']
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
    parts: ['body', 'image', 'repeater']
  }, {
    name: 'demo',
    title: 'Demo',
    description: 'Contains examples of every page part',
    page_parts: [],
    parts: ['body', 'image_collection', 'image', 'repeater']
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

  theme.plugins = ['reviews']

end
