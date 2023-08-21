module Spina
  module Admin
    class NavigationsController < AdminController
      before_action :set_breadcrumb
      before_action :set_navigation, only: [:edit, :update]

      admin_section :content

      def index
        navigation = Spina::Navigation.order(:position).first
        if navigation
          redirect_to spina.edit_admin_navigation_path(navigation)
        end
      end

      def edit
        @navigations = Spina::Navigation.order(:position)
        render layout: "spina/admin/admin"
      end

      def update
        if @navigation.update(navigation_params)
          redirect_to spina.edit_admin_navigation_path(@navigation)
        else
          render :edit
        end
      end

      def sort
        params[:ids].each.with_index do |id, index|
          NavigationItem.where(id: id).update_all(position: index + 1)
        end

        flash.now[:info] = t("spina.navigations.sorting_saved")
        render_flash
      end

      private

      def update_navigation_item_position(navigation_item_id, position, parent_id = nil)
        Spina::NavigationItem.update(navigation_item_id, position: position.to_i + 1, parent_id: parent_id)
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
        add_breadcrumb t("spina.navigations.navigations")
      end

      def navigation_params
        params.require(:navigation).permit(:label, :auto_add_pages, page_ids: [])
      end

      def set_navigation
        @navigation = Navigation.find(params[:id])
      end
    end
  end
end
