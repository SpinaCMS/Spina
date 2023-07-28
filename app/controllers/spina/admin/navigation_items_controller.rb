module Spina
  module Admin
    class NavigationItemsController < AdminController
      before_action :set_navigation

      def new
        @navigation_item = @navigation.navigation_items.new(parent_id: params[:parent_id])
        @pages = Page.sorted.main.includes(:translations)
      end

      def create
        @navigation_item = @navigation.navigation_items.new(navigation_item_params)
        if @navigation_item.save
          redirect_to spina.edit_admin_navigation_path(@navigation)
        else
          @pages = Page.sorted.main.includes(:translations)
          render turbo_stream: turbo_stream.update(:navigation_item_form, partial: "form")
        end
      end

      def edit
        @navigation_item = NavigationItem.find(params[:id])
        @pages = Page.sorted.main.includes(:translations)
      end

      def update
        @navigation_item = NavigationItem.find(params[:id])

        if @navigation_item.update(navigation_item_params)
          redirect_to spina.edit_admin_navigation_path(@navigation)
        else
          @pages = Page.sorted.main.includes(:translations)
          render turbo_stream: turbo_stream.update(:navigation_item_form, partial: "form")
        end
      end

      def destroy
        @navigation_item = @navigation.navigation_items.find(params[:id])
        @navigation_item.destroy
        render turbo_stream: turbo_stream.remove(view_context.dom_id(@navigation_item, :container))
      end

      def get_form
        @navigation_item = @navigation.navigation_items.find_or_initialize_by(id: params[:id])
        @navigation_item.parent_id = params[:parent_id]
        
        if params[:kind] == "url"
          render "url_form"
        else
          @pages = Page.sorted.main.includes(:translations)
          render "page_form"
        end
      end

      private

      def navigation_item_params
        params.require(:navigation_item).permit(
          :kind,
          :page_id,
          :parent_id,
          :url_title,
          :url
        ).merge(navigation_id: @navigation.id)
      end

      def set_navigation
        @navigation = Navigation.find(params[:navigation_id])
      end
    end
  end
end
