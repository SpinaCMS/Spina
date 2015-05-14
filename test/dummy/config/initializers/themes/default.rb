module Spina
  module DefaultTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = "Default theme"

    self.page_parts = [{ 
      name: 'content', 
      title: 'Content', 
      page_partable_type: "Spina::Text" 
    }, {
      name: "structure",
      title: "Structuur",
      page_partable_type: "Spina::Structure"
    }]

    self.structures = {
      'structure' => [{
        name: 'name',
        title: 'Naam',
        structure_partable_type: "Spina::Line"
      }, {
        name: 'description',
        title: "Description",
        structure_partable_type: "Spina::Text"  
      }]
    }
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
        page_parts: ['content', 'structure']
      }
    }

    self.custom_pages = [
      { name: 'homepage', title: 'Homepage', deletable: false, view_template: 'homepage' }
    ]
  end
end

theme = Spina::Theme.new
theme.name = "default"
theme.config = Spina::DefaultTheme.config
Spina.register_theme(theme)
