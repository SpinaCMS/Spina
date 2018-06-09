module Spina
  module Admin
    class PagesController < AdminController
      before_action :set_tabs, only: [:new, :create, :edit, :update]
      before_action :set_locale

      def index
        add_breadcrumb I18n.t('spina.website.pages'), spina.admin_pages_path
        redirect_to admin_pages_path unless current_admin_path.starts_with?('/pages')
        @pages = Page.active.sorted.roots.regular_pages
      end

      def new
        @resource = Resource.find_by(id: params[:resource_id])
        @page = Page.new(resource: @resource, parent: @resource&.parent_page)
        add_index_breadcrumb
        if current_theme.new_page_templates.any? { |template| template[0] == params[:view_template] }
          @page.view_template = params[:view_template]
        end
        add_breadcrumb I18n.t('spina.pages.new')
        @page_parts = @page.view_template_page_parts(current_theme).map { |part| @page.part(part) }
        render layout: 'spina/admin/admin'
      end

      def create
        @page = Page.new(page_params)
        add_breadcrumb I18n.t('spina.pages.new')
        if @page.save
          @page.navigations << Spina::Navigation.where(auto_add_pages: true)
          redirect_to spina.edit_admin_page_url(@page), flash: {success: t('spina.pages.saved')}
        else
          @page_parts = @page.view_template_page_parts(current_theme).map { |part| @page.part(part) }
          render :new, layout: 'spina/admin/admin'
        end
      end

      def edit
        @page = Page.find(params[:id])
        add_index_breadcrumb
        add_breadcrumb @page.title
        @page_parts = @page.view_template_page_parts(current_theme).map { |part| @page.part(part) }
        render layout: 'spina/admin/admin'
      end

      def update
        I18n.locale = params[:locale] || I18n.default_locale
        @page = Page.find(params[:id])
        respond_to do |format|
          if @page.update_attributes(page_params)
            add_breadcrumb @page.title
            @page.touch
            I18n.locale = I18n.default_locale
            format.html { redirect_to spina.edit_admin_page_url(@page, params: {locale: @locale}), flash: {success: t('spina.pages.saved')} }
            format.js
          else
            format.html do
              @page_parts = @page.view_template_page_parts(current_theme).map { |part| @page.part(part) }
              render :edit, layout: 'spina/admin/admin'
            end
          end
        end
      end

      def sort
        params[:list].each_pair do |parent_pos, parent_node|
          update_child_pages_position(parent_node)
          update_page_position(parent_node, parent_pos, nil)
        end
        head :ok
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

      def add_index_breadcrumb
        if @page.resource.present?
          add_breadcrumb @page.resource.label, spina.admin_resource_path(@page.resource)
        else
          add_breadcrumb I18n.t('spina.website.pages'), spina.admin_pages_path
        end
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
        params.require(:page).permit!
      end

    end
  end
end
