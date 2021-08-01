module Spina::Api
  class BaseSerializer
    include JSONAPI::Serializer
    singleton_class.include Spina::Engine.routes.url_helpers
  end
end