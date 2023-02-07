module Spina
  module Admin
    class PageSelectOptionsController < AdminController
      
      def show
        @page = Page.find(params[:id])
      end
      
      def index
      end
      
      def search
        if params[:resource].present?
          @pages = Resource.find_by(name: params[:resource])&.pages
        end
        
        @pages ||= Page.all
        @pages = @pages.joins(:translations).where("spina_page_translations.title ILIKE :query OR materialized_path ILIKE :query", query: "%#{params[:search]}%").order(created_at: :desc).distinct.page(params[:page]).per(20)
        render :index
      end
      
    end
  end
end