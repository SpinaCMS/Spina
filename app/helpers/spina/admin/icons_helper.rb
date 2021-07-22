require 'nokogiri'

module Spina::Admin
	module IconsHelper
	
		class FileNotFound < StandardError
	  end
		
		def heroicon(name, style: :outline, **options)
	    file = read_file(Spina::Engine.root.join("app/assets/icons/heroicons", style.to_s, "#{name}.svg"))
	    
	    doc = Nokogiri::XML(file)
	    svg = doc.root
	    svg[:class] = options[:class]
	    ActiveSupport::SafeBuffer.new(svg.to_s)
		end
		
		private
		
	    def read_file(path)
	      File.exist?(path) || raise(FileNotFound, "File #{path} not found")
	      File.read(path)
	    end  

	end
end