module Spina::Pages
  class PageSelectComponent < Spina::ApplicationComponent
    attr_accessor :name, :pages, :include_blank, :selected, :disabled
    
    def initialize(name, pages, include_blank: false, selected: nil, disabled: nil)
      @name = name
      @pages = pages
      @include_blank = include_blank
      @selected = selected
      @disabled = disabled
    end
    
    def options
      Spina::Page.sort_by_ancestry(pages.arrange(order: :position)).map do |page|
        page_menu_title = page.menu_title.indent(page.depth, '–')
        [page_menu_title, page.id]
      end
    end

  end
end
