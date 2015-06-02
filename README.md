![Spina CMS](http://www.denkwebsite.nl/spinacms.png)

[Visit the website](http://www.spinacms.com)

[![Code Climate](https://codeclimate.com/github/denkGroot/Spina/badges/gpa.svg)](https://codeclimate.com/github/denkGroot/Spina) [![Test Coverage](https://codeclimate.com/github/denkGroot/Spina/badges/coverage.svg)](https://codeclimate.com/github/denkGroot/Spina/coverage) [ ![Codeship Status for denkGroot/Spina](https://codeship.com/projects/e13debf0-e6af-0132-8abf-32d84f3372de/status?branch=master)](https://codeship.com/projects/82322)

# Getting Started

Spina is a CMS built upon the Rails framework. This guide is designed for developers with experience using Ruby on Rails. 

To start using Spina CMS simply add the following lines to your Gemfile:

    gem 'spina-template'
    gem 'spina'

Make sure you run the installer to get started.

    rails g spina:install

The installer will help you setup your first user.

# Basics

The installer generates a few initializers that contain necessary configuration for Spina.

In the initializers folder there's a new folder named *themes*. Inside you will find a configuration file named default.rb. This file contains all of your theme-specific settings. You can define multiple Page parts, Layout parts, View templates and Custom pages.

## Page parts

A page in Spina has many Page parts. By default these page parts can be one of the following:

- Spina::Line
- Spina::Text
- Spina::Photo
- Spina::PhotoCollection
- Spina::Color
- Spina::Structure

These are the building blocks of your view templates. You can have an unlimited number of page parts in a page. We prefer to keep the number of parts to a minimum so that managing your pages won't become too complex.

## Layout parts

Sometimes you need editable content that's not specific to a view template but to your theme as a whole. You can use the following parts in your layout.

- Spina::Line
- Spina::Color

## View templates

Each theme typically has a few different view templates which make up your website. By default Spina generates a *homepage* and *show* template.

The views for these templates are stored in app/views/default/pages.

## Custom pages

You can define custom pages for your theme that will be generated when bootstrapping your website. You can define wether or not they're deletable. By default Spina creates a custom page named Homepage which is not deletable.

# License

Spina is released under the MIT license.

# Credits

Some parts of Spina are heavily influenced by the wonderful Refinery CMS. Credits to [Resolve Digital](http://resolve.digital).
