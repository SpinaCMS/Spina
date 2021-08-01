module Spina::Api
  class ResourceSerializer < BaseSerializer
    set_type :resource
    
    attributes :name, :label, :view_template, :order_by, :slug
    
    has_many :pages, lazy_load_data: true, links: {
      self: -> (object) { api_resource_path(object.id) },
      related: -> (object) { api_resource_pages_path(object.id) }
    }, meta: -> (resource) { {count: resource.pages.live.length} }
  end
end
