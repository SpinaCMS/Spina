Spina::Engine.configure do
  config.NEGATIVE_CAPTCHA_SECRET = 'abc'
end

module Spina
  module DefaultTheme
    include ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins

    self.title = "Default theme"

    self.page_parts = [{ 
      name: 'content', 
      title: 'Content', 
      page_partable_type: "Spina::Text" 
    }, { 
      name: 'team', 
      title: 'Team', 
      page_partable_type: "Spina::Structure", 
      structure: [{
        name: 'name',
        title: 'Naam',
        page_partable_type: "Spina::Line"
      }, {
        name: 'description',
        title: 'Omschrijving',
        page_partable_type: "Spina::Text"  
      }]
    }]

    self.layout_parts = []

    self.custom_pages = []
    self.plugins = []

    self.view_templates = {
      'show' => {
        title: 'Default',
        description: 'Default template',
        usage: 'Default page',
        page_parts: ['content', 'team']
      }
    }
  end
end

theme = Spina::Theme.new
theme.name = "Default theme"
theme.config = Spina::DefaultTheme.config
Spina.register_theme(theme)
