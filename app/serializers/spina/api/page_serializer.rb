module Spina::Api
  class PageSerializer < BaseSerializer    
    set_type :page
    
    attributes :title, :seo_title, :menu_title, :materialized_path, :name, :description, :view_template
    
    attribute(:content) { |page| page_content(page) }
    
    belongs_to :resource

    class << self
      
      def page_content(page)
        return [] unless view_template(page)
        
        view_template(page)[:parts].map do |part| 
          { part => page.content(part) }
        end
      end
      
      def view_template(page)
        Spina::Current.theme.view_templates.find{|view_template| view_template[:name] == page.view_template}
      end
      
    end
    
  end
end
