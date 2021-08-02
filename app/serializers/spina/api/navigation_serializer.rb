module Spina::Api
  class NavigationSerializer < BaseSerializer    
    set_type :navigation
    
    attributes :name, :label
    
    attribute :tree do |navigation|
      items_to_tree(navigation.navigation_items.sorted.roots.in_menu.live.joins(:page))
    end
    
    class << self
      
      def items_to_tree(collection)
        collection.map do |item|
          {
            depth: item.depth,
            page: {
              id: item.page_id,
              menu_title: item.menu_title,
              materialized_path: item.materialized_path
            },
            children: items_to_tree(item.children.sorted.in_menu.live.joins(:page))
          }
        end
      end
      
    end
    
  end
end
