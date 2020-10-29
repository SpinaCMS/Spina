module Spina
  module Admin
    class MovePagesController < AdminController
      
      def new
        @page = Page.find(params[:page_id])
      end
      
      def update
        @page = Page.find(params[:page_id])
        @page.update(page_params)
        flash[:success] = t('spina.pages.moved')
        redirect_back fallback_location: spina.edit_admin_page_url(@page)
      end
      
      private
      
        def page_params
          params.require(:page).permit(:parent_id, :resource_id)
        end
      
    end
  end
end