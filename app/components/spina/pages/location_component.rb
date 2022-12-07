module Spina::Pages
  class LocationComponent < Spina::ApplicationComponent
    attr_accessor :f

    def initialize(f, page = nil)
      @f = f
      @page = page
    end

    def resources
      [main_collection_option] + Spina::Resource.order(:label).map do |resource|
        [resource.label, resource.id, data: {
          parent_pages_url: helpers.spina.admin_parent_pages_path(resource_id: resource.id)
        }]
      end
    end

    def main_collection_option
      [t("spina.pages.main_collection"), nil, data: {
        parent_pages_url: helpers.spina.admin_parent_pages_path
      }]
    end

    def default_parent_pages_path
      helpers.spina.admin_parent_pages_path(resource_id: @page&.resource_id, parent_id: @page&.parent_id, page_id: @page&.id)
    end
  end
end
