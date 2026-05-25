class Spina::ThemeReloader
  delegate :execute_if_updated, :execute, :updated?, to: :updater

  def reload!
    Spina::PageTemplate.clear_all
    theme_initializer_paths.each { |path| load path }
  end

  private

  def updater
    @updater ||= Rails.application.config.file_watcher.new(theme_paths) do
      reload!
    end
  end

  def theme_paths
    theme_initializer_paths + template_paths
  end

  def theme_initializer_paths
    Rails.root.glob("config/initializers/themes/*.rb").to_a
  end

  def template_paths
    Rails.root.glob("app/templates/spina/**/*.rb").to_a
  end
end
