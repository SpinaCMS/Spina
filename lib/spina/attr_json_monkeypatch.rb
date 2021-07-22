module Spina
  module AttrJsonMonkeypatch 
    extend ActiveSupport::Concern
    
    included do |base|
      extend ClassMethods
    end
    
    module ClassMethods
    
      def attr_json_setter_monkeypatch(name)
        # Ruby bug in 3.0.0 related to defined?(super) returning true
        # https://github.com/jrochkind/attr_json/issues/112
        if RUBY_VERSION == "3.0.0" && RUBY_PATCHLEVEL == 0
          define_method("#{name}=") do |value|
            # This next line is uncommented in the attr_json gem
            # We don't care about super here, so let's just comment it for now
            # super(value) if defined?(super)
            attribute_def = self.class.attr_json_registry.fetch(name.to_sym)
            public_send(attribute_def.container_attribute)[attribute_def.store_key] = attribute_def.cast(value)
          end
        end
      end
      
    end
  
  end
end