module Spina
  module Admin
    class NavigationsController < AdminController
      layout 'spina/admin/pages'

      before_action :set_breadcrumb, except: [:show]
      before_action :set_navigation, only: [:show, :edit, :update]

      def show        
        add_breadcrumb t('spina.website.pages')
      end

      def edit        
        add_breadcrumb @navigation.label, spina.admin_navigation_path(@navigation)
        add_breadcrumb t('spina.edit')
        render layout: 'spina/admin/admin'
      end

      def update        
        if @navigation.update_attributes(navigation_params)
          redirect_to spina.admin_navigation_path(@navigation)
        else
          render :edit
        end
      end

      def sort
        params[:list].each_pair do |parent_pos, parent_node|
          update_child_pages_position(parent_node)
          update_navigation_item_position(parent_node[:id], parent_pos, nil)
        end
        head :ok
      end

      private

        def update_navigation_item_position(navigation_item_id, position, parent_id = nil)
          Spina::NavigationItem.update(navigation_item_id, position: position.to_i + 1, parent_id: parent_id )
        end

        def update_child_pages_position(node)
          if node[:children].present?
            node[:children].each_pair do |child_pos, child_node|
              update_child_pages_position(child_node) if child_node[:children].present?
              update_navigation_item_position(child_node[:id], child_pos, node[:id])
            end
          end
        end

        def set_breadcrumb
          add_breadcrumb t('spina.website.pages'), spina.admin_pages_path
        end

        def navigation_params
          params.require(:navigation).permit(:auto_add_pages, page_ids: [])
        end

        def set_navigation
          @navigation = Navigation.find(params[:id])
        end
    end
  end
end