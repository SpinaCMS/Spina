module Spina
  module ImportmapHelper
  
    def spina_importmap_with_stimulus_from(*paths)
      [ %("stimulus": "#{asset_path("stimulus/libraries/stimulus")}"), spina_importmap_from(*paths) ].reject(&:blank?).join(",\n")
    end
  
    def spina_importmap_from(*paths, prepend: "spina")
      Array(paths).flat_map do |path|
        if (absolute_path = absolute_root_of(path)).exist?
          find_javascript_files_in_tree(absolute_path).collect do |filename|
            module_filename = filename.relative_path_from(absolute_path)
            module_name     = importmap_module_name_from(module_filename)
            module_path     = asset_path("#{prepend}/" + absolute_path.basename.join(module_filename).to_s)
      
            %("#{module_name}": "#{module_path}")
          end
        end
      end.compact.join(",\n")
    end
  
    private
      
      # Strip off the extension and any versioning data for an absolute module name.
      def importmap_module_name_from(filename)
        filename.basename.to_s.remove(filename.extname).split("@").first
      end
    
      def find_javascript_files_in_tree(path)
        Dir[path.join("**/*.js{,m}")].collect { |file| Pathname.new(file) }.select(&:file?)
      end
    
      def absolute_root_of(path)
        (pathname = Pathname.new(path)).absolute? ? pathname : Rails.root.join(path)
      end
  end
end