module Spina
  module DeprecatedTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = 'Deprecated theme'

    self.page_parts = [{
      name:               'text',
      title:              'Text',
      page_partable_type: 'Spina::Text'
    }]

    self.structures = {}

    self.layout_parts = []

    self.view_templates = {
      'homepage' => {
        title:      'Homepage',
        page_parts: ['text']
      },
      'show' => {
        title:        'Deprecated',
        description:  'A simple page',
        usage:        'Use for your content',
        page_parts:   ['text']
      }
    }

    self.custom_pages = [{
      name:           'homepage',
      title:          'Homepage',
      deletable:      false,
      view_template:  'homepage'
    }]

    self.plugins = []

  end
end

theme = Spina::Theme.new
theme.name = 'deprecated'
theme.config = Spina::DeprecatedTheme.config
Spina.register_theme(theme)

