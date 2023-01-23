module Spina
  module Admin
    class PageSelectOptionsController < AdminController
      
      def show
        @page = Page.find(params[:id])
      end
      
      def index
      end
      
      def search
        @pages = Page.joins(:translations).where("spina_page_translations.title ILIKE ?", "%#{params[:search]}%").page(params[:page]).per(20)
        render :index
      end
      
    end
  end
end