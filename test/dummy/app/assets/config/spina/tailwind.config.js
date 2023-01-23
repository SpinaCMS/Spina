module.exports = {
  content: [
    '/Users/bram/apps/spina/app/views/**/*.*',
'/Users/bram/apps/spina/app/components/**/*.*',
'/Users/bram/apps/spina/app/helpers/**/*.*',
'/Users/bram/apps/spina/app/assets/javascripts/**/*.js',
'/Users/bram/apps/spina/app/**/application.tailwind.css'
  ],
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#797ab8',
          DEFAULT: '#6865b4',
          dark: '#3a3a70'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
	require('@tailwindcss/aspect-ratio'),
	require('@tailwindcss/typography')
  ]
}
