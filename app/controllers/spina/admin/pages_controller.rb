module Spina
  module Admin
    class PagesController < AdminController
      before_action :set_locale
      before_action :set_page, only: [:edit, :edit_content, :edit_template, :update, :destroy, :children, :sort_one]
      before_action :set_tabs

      def index
        add_breadcrumb I18n.t("spina.website.pages"), spina.admin_pages_path

        if params[:resource_id]
          @resource = Resource.find(params[:resource_id])
          @page_templates = Spina::Current.theme.new_page_templates(resource: @resource)
          @pages = @resource.pages.active.roots.includes(:translations).page(params[:page]).per(Spina.config.resource_pages_limit_value)
        else
          @pages = Page.active.sorted.roots.main.includes(:translations)
          @page_templates = Spina::Current.theme.new_page_templates
        end
      end

      def new
        resource = Resource.find_by(id: params[:resource_id])
        @page = Page.new(view_template: params[:view_template], resource: resource)
      end

      def create
        @page = Page.new(page_params.merge(draft: true))
        if @page.save
          redirect_to spina.edit_admin_page_url(@page)
        else
          render turbo_stream: turbo_stream.update(view_context.dom_id(@page, :new_page_form), partial: "new_page_form")
        end
      end

      def edit
        add_index_breadcrumb
        add_breadcrumb @page.title
      end

      def edit_content
        @parts = current_theme.view_templates.find do |view_template|
          view_template[:name].to_s == @page.view_template.to_s
        end&.dig(:parts) || []
      end

      def edit_template
        render layout: false
      end

      def update
        Mobility.locale = @locale
        if @page.update(page_params)
          if @page.saved_change_to_draft? && @page.live?
            flash[:confetti] = t("spina.pages.published")
          else
            flash[:success] = t("spina.pages.saved")
          end

          redirect_to spina.edit_admin_page_url(@page, params: {locale: @locale})
        else
          add_index_breadcrumb
          Mobility.locale = I18n.locale
          add_breadcrumb @page.title
          flash.now[:error] = t("spina.pages.couldnt_be_saved")
          render :edit, status: :unprocessable_entity
        end
      end

      def sort
        params[:ids].each.with_index do |id, index|
          Page.where(id: id).update_all(position: index + 1)
        end

        flash.now[:info] = t("spina.pages.sorting_saved")
        render_flash
      end

      def sort_one
        current_position = @page.position

        if params[:direction] == "up"
          @bottom_page = @page
          @top_page = @target_page = @page.siblings.where(resource_id: @page.resource_id).sorted.where("position < ?", current_position).last
        else
          @bottom_page = @target_page = @page.siblings.where(resource_id: @page.resource_id).sorted.where("position > ?", current_position).first
          @top_page = @page
        end

        if @target_page
          @page.transaction do
            @page.update(position: @target_page.position)
            @target_page.update(position: current_position)
          end
          flash.now[:info] = t("spina.pages.sorting_saved")
        else
          head :ok
        end
      end

      def children
        @children = @page.children.active.sorted
        render layout: false
      end

      def destroy
        flash[:info] = t("spina.pages.deleted")
        @page.destroy

        redirect_to spina.admin_pages_url(resource_id: @page.resource_id)
      end

      private

      def set_locale
        @locale = params[:locale] || I18n.default_locale
      end

      def add_index_breadcrumb
        if @page.resource
          add_breadcrumb @page.resource.label, spina.admin_pages_path(resource_id: @page.resource_id), class: "text-gray-400"
        else
          add_breadcrumb t("spina.website.pages"), spina.admin_pages_path, class: "text-gray-400"
        end
      end

      def page_params
        params.require(:page).permit!
      end

      def set_page
        @page = Page.find(params[:id])
      end

      def set_tabs
        @tabs = %w[page_content search_engines advanced]
      end
    end
  end
end
