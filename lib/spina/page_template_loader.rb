module Spina
  class PageTemplateLoader
    class << self
      def load(path, theme_name:)
        absolute_path = Rails.root.join(path)
        return unless absolute_path.directory?

        PageTemplate.clear_for_theme(theme_name)
        LayoutParts.clear_for_theme(theme_name)
        ensure_template_constants!

        PageTemplate.with_theme(theme_name) do
          LayoutParts.with_theme(theme_name) do
            layout_file = absolute_path.join("layout.rb")
            load_template_file(layout_file) if layout_file.file?

            absolute_path.glob("**/*.rb").sort.each do |file|
              next if file.basename.to_s == "layout.rb"

              load_template_file(file)
            end
          end
        end
      end

      private

      def ensure_template_constants!
        Object.const_set(:PageTemplate, Spina::PageTemplate) unless defined?(::PageTemplate)
        Object.const_set(:LayoutParts, Spina::LayoutParts) unless defined?(::LayoutParts)
      end

      def load_template_file(file)
        Kernel.load file.to_s
      end
    end
  end
end
