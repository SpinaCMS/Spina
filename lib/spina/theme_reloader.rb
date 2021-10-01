class Spina::ThemeReloader
  delegate :execute_if_updated, :execute, :updated?, to: :updater
  
  def reload!
    theme_paths.each { |path| load path }
  end
  
  private
  
    def updater
      @updater ||= Rails.application.config.file_watcher.new(theme_paths) do 
        reload!
      end
    end
  
    def theme_paths
      Rails.root.glob("config/initializers/themes/*.rb") 
    end
  
end