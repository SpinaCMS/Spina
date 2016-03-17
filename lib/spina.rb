require 'spina/engine'
require 'spina/template'

module Spina

  include ActiveSupport::Configurable

  config_accessor :backend_path, :storage

  self.backend_path = 'admin'

  self.storage = :file

  self.max_page_depth = 5

  class << self

    def register_theme(theme)
      new_theme = Spina::Theme.new(
        name:           theme.name,
        title:          theme.config.title,
        page_parts:     theme.config.page_parts,
        view_templates: theme.config.view_templates,
        layout_parts:   theme.config.layout_parts,
        custom_pages:   theme.config.custom_pages,
        plugins:        theme.config.plugins,
        structures:     theme.config.structures,
      )
      Spina::Theme.register(new_theme)
    end

  end

end
