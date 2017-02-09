module Spina
  module Pages
    module Property

      extend ActiveSupport::Concern

      included do
        scope :sorted, -> { order('position') }
        scope :custom_pages, -> { where(deletable: false) }
        scope :live, -> { where(draft: false, active: true) }
        scope :in_menu, -> { where(show_in_menu: true) }
        scope :active, -> { where(active: true) }
        scope :not_active, -> { where(active: false) }
        scope :by_name, ->(name) { where(name: name) }
        scope :not_by_config_theme, ->(theme) { where.not(view_template: theme.view_templates.map { |h| h[:name] }) }
        scope :by_config_theme, ->(theme) { where(view_template: theme.view_templates.map { |h| h[:name] }) }
      end

      def to_s
        name
      end

      def url_title
        title.try(:parameterize)
      end

      def custom_page?
        !deletable
      end

      def menu_title
        read_attribute(:menu_title).blank? ? title : read_attribute(:menu_title)
      end

      def seo_title
        read_attribute(:seo_title).blank? ? title : read_attribute(:seo_title)
      end

      def live?
        !draft? && active?
      end

      def previous_sibling
        self.siblings.where('position < ?', self.position).sorted.last
      end

      def next_sibling
        self.siblings.where('position > ?', self.position).sorted.first
      end

      def cache_key
        super + "_" + Globalize.locale.to_s
      end

      def view_template_config(theme)
        view_template_name = view_template.presence || 'show'
        theme.view_templates.find { |template| template[:name] == view_template_name }
      end

      def full_materialized_path
        File.join(Spina::Engine.routes.url_helpers.root_path, materialized_path)
      end

    end
  end
end
