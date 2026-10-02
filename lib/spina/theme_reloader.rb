class Spina::ThemeReloader
  delegate :execute_if_updated, :execute, :updated?, to: :updater

  def reload!
    Spina::PageTemplate.clear_all
    theme_initializer_paths.each { |path| load path }
    # Rebuild so custom theme.load_templates_from paths picked up during reload are watched.
    @updater = nil
  end

  private

  def updater
    @updater ||= Rails.application.config.file_watcher.new([], watched_dirs) do
      reload!
    end
  end

  def watched_dirs
    dirs = {}
    add_watched_dir!(dirs, Rails.root.join("config/initializers/themes"), ["rb"])
    add_watched_dir!(dirs, Rails.root.join("app/templates/spina"), ["rb"])

    Spina::Theme.all.each do |theme|
      next if theme.templates_path.blank?

      add_watched_dir!(dirs, Rails.root.join(theme.templates_path), ["rb"])
    end

    dirs
  end

  def add_watched_dir!(dirs, path, extensions)
    path = path.to_s
    return unless File.directory?(path)

    dirs[path] = extensions
  end

  def theme_initializer_paths
    Rails.root.glob("config/initializers/themes/*.rb").sort
  end
end
