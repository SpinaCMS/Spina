module Spina
  module Admin
    class PagesController < AdminController

      before_action :set_breadcrumb
      before_action :set_tabs, only: [:new, :create, :edit, :update]
      before_action :set_locale

      authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = Page.active.sorted.roots
      end

      def new
        @page = Page.new
        if current_theme.new_page_templates.any? { |template| template[0] == params[:view_template] }
          @page.view_template = params[:view_template]
        end
        add_breadcrumb I18n.t('spina.pages.new')
        @page_parts = current_theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def create
        @page = Page.new(page_params)
        add_breadcrumb I18n.t('spina.pages.new')
        # @page.set_materialized_path
        if @page.save
          redirect_to spina.edit_admin_page_url(@page)
        else
          @page_parts = @page.page_parts
          render :new
        end
      end

      def edit
        @page = Page.find(params[:id])
        add_breadcrumb @page.title
        @page_parts = current_theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def update
        I18n.locale = params[:locale] || I18n.default_locale
        @page = Page.find(params[:id])
        add_breadcrumb @page.title
        respond_to do |format|
          if @page.update_attributes(page_params)
            I18n.locale = I18n.default_locale
            format.html { redirect_to spina.edit_admin_page_url(@page, params: {locale: @locale}) }
            format.js
          else
            format.html do
              @page_parts = @page.page_parts
              render :edit
            end
          end
        end
      end

      def sort
        params[:list].each_pair do |parent_pos, parent_node|
          update_child_pages_position(parent_node)
          update_page_position(parent_node, parent_pos, nil)
        end
        render nothing: true
      end

      def destroy
        @page = Page.find(params[:id])
        @page.destroy
        redirect_to spina.admin_pages_url
      end

      private

      def set_locale
        @locale = params[:locale] || I18n.default_locale
      end

      def set_breadcrumb
        add_breadcrumb I18n.t('spina.website.pages'), spina.admin_pages_path
      end

      def set_tabs
        @tabs = %w{page_content page_seo advanced}
      end

      def update_page_position(page, position, parent_id = nil)
        Page.update(page[:id], position: position.to_i + 1, parent_id: parent_id )
      end

      def update_child_pages_position(node)
        if node[:children].present?
          node[:children].each_pair do |child_pos, child_node|
            update_child_pages_position(child_node) if child_node[:children].present?
            update_page_position(child_node, child_pos, node[:id])
          end
        end
      end

      def page_params
        params.require(:page).permit!.merge(locale: params[:locale] || I18n.default_locale)
      end

    end
  end
end
