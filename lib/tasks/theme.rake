namespace :spina do
  namespace :theme do
    desc "Migrate a theme initializer to page template files (usage: spina:theme:migrate_templates[theme_name])"
    task :migrate_templates, [:theme_name] => :environment do |_task, args|
      theme_name = args[:theme_name].presence || Spina::Account.first&.theme || "default"
      theme = Spina::Theme.find_by_name(theme_name)

      unless theme
        abort "Theme #{theme_name.inspect} not found. Register it in config/initializers/themes first."
      end

      if theme.parts.blank? || theme.view_templates.blank?
        abort "Theme #{theme_name.inspect} has no legacy theme.parts/theme.view_templates to migrate."
      end

      migrator = Spina::ThemeMigrator.new(theme)
      path = migrator.migrate_to

      initializer_path = Rails.root.join("config/initializers/themes/#{theme_name}.rb")
      backup_path = ThemeMigrator.initializer_backup_path(theme_name, root: Rails.root)

      if File.exist?(initializer_path)
        FileUtils.cp(initializer_path, backup_path)
        File.write(initializer_path, migrator.slim_initializer_content)
      end

      puts "Migrated #{theme.view_templates.size} page templates to #{path}"
      puts "Updated #{initializer_path}"
      puts "Removed theme.parts and theme.view_templates from the theme initializer."
      puts "Backup saved to #{backup_path}" if File.exist?(backup_path)
    end
  end
end
