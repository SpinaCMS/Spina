module Spina
  module DefaultTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = "Default theme"

    self.page_parts = [{ 
      name: 'content', 
      title: 'Content', 
      page_partable_type: "Spina::Text" 
    }]

    self.structures = []
    self.layout_parts = []
    self.custom_pages = []
    self.plugins = []

    self.view_templates = {
      'homepage' => {
        title: 'Homepage',
        page_parts: ['content']
      },
      'show' => {
        title: 'Default',
        description: 'A simple page',
        usage: 'Use for your content',
        page_parts: ['content']
      }
    }
  end
end

theme = Spina::Theme.new
theme.name = "Default"
theme.config = Spina::DefaultTheme.config
Spina.register_theme(theme)
