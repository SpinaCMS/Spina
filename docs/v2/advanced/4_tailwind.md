# Tailwind

Spina uses [Tailwind 3](https://tailwindcss.com) as its CSS framework to build all views. It uses the [tailwindcss-rails](https://github.com/rails/tailwindcss-rails) gem which includes a CLI for generating Tailwind's CSS.

Spina hooks into your main app's `assets:precompile` task and adds the following steps:

1. Capture all paths that need to be scanned for Tailwind classes from `Spina.config.tailwind_content`
2. Generate a new Tailwind configuration file in `app/assets/config/spina/tailwind.config.js`
3. Use the Tailwind executable to compile Tailwind
4. Save Tailwind build to `app/assets/builds/spina/tailwind.css`

Spina plugins can add paths to the `Spina.config.tailwind_content` array which is then added to the Tailwind configuration file. This setup ensures that your Tailwind build always includes all classes needed when precompiling assets in production.

If you're developing a Spina plugin, you can use the `rails spina:tailwind:build` and `rails spina:tailwind:watch` tasks to generate new builds locally. 