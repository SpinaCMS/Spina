module Spina
  class Account < ApplicationRecord
    include Partable
    
    serialize :preferences

    mount_uploader :logo, LogoUploader

    has_many :layout_parts, dependent: :destroy
    accepts_nested_attributes_for :layout_parts, allow_destroy: true

    alias_attribute :layout_part, :part
    alias_attribute :parts, :layout_parts

    def to_s
      name
    end

    def content(layout_part)
      layout_parts.find_by(name: layout_part).try(:content)
    end

    def self.serialized_attr_accessor(*args)
      args.each do |method_name|
        eval "
          def #{method_name}
            self.preferences.try(:[], :#{method_name})
          end

          def #{method_name}=(value)
            self.preferences ||= {}
            self.preferences[:#{method_name}] = value
          end
        "
      end
    end

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :google_plus, :theme
  end
end
