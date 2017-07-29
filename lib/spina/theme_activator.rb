module Spina
  class ThemeActivator
    attr_accessor :theme
    
    def initialize(theme)
      @theme = Spina::Theme.find_by_name(theme)
    end

    def activate!
      activate_pages(theme)
      activate_navigations(theme)
    end

    private

      def activate_pages(theme)
        find_or_create_custom_pages(theme)
        deactivate_unused_view_templates(theme)
        activate_used_view_templates(theme)
      end

      def activate_navigations(theme)
        theme.navigations.each_with_index do |navigation, index|
          Navigation.where(name: navigation[:name]).first_or_create.update_attributes(navigation.merge(position: index))
        end
      end

      def find_or_create_custom_pages(theme)
        theme.custom_pages.each do |page|
          Page.where(name: page[:name])
              .first_or_create(title: page[:title])
              .update_attributes(view_template: page[:view_template], deletable: page[:deletable])
        end
      end

      def deactivate_unused_view_templates(theme)
        Page.active.where.not(view_template: theme.view_templates.map{|h|h[:name]}).update_all(active: false)
      end

      def activate_used_view_templates(theme)
        Page.where(active: false, view_template: theme.view_templates.map{|h|h[:name]}).update_all(active: true)
      end

  end
end
