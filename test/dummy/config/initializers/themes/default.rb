page_parts = [{
  name:               'text',
  title:              'Text',
  page_partable_type: 'Spina::Text'
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
  }
}

custom_pages = [{
  name:           'homepage',
  title:          'Homepage',
  deletable:      false,
  view_template:  'homepage'
}]

theme = Spina::Theme.new(
  name:           'default',
  title:          'Default Theme',
  page_parts:     page_parts,
  view_templates: view_templates,
  custom_pages:   custom_pages
)
Spina::Theme.register(theme)
