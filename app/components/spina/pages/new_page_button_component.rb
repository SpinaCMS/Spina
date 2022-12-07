module Spina::Pages
  class NewPageButtonComponent < Spina::ApplicationComponent
    attr_reader :view_templates, :resource

    def initialize(view_templates = [], resource: nil)
      @view_templates = view_templates
      @resource = resource
    end

    def view_template
      view_templates.first
    end

    def render?
      view_templates.any?
    end
  end
end
