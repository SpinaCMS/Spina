module Spina
  module DefaultTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = 'Default theme'

    self.page_parts = [{
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
      name:               'structure',
      title:              'Structure',
      page_partable_type: 'Spina::Structure'
    }, {
      name:               'color',
      title:              'Color',
      page_partable_type: 'Spina::Color'
    }]

    self.structures = {
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

    self.layout_parts = [{
      name:               'line',
      title:              'Line',
      page_partable_type: 'Spina::Line'
    }, {
      name:               'text',
      title:              'Text',
      page_partable_type: 'Spina::Text'
    }]

    self.view_templates = {
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
        title:        'Demo',
        description:  'Example page',
        usage:        'Shows the usage of several page parts',
        page_parts:   ['line', 'text', 'photo', 'photo_collection', 'structure', 'color']
      }
    }

    self.custom_pages = [{
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

    self.plugins = []

  end
end

theme = Spina::Theme.new
theme.name = 'default'
theme.config = Spina::DefaultTheme.config
Spina.register_theme(theme)
