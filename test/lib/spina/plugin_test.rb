require 'test_helper'

module Spina
  module SpinaTest
    class Engine < ::Rails::Engine
      isolate_namespace ::Spina

      config.before_initialize do
        ::Spina::Plugin.register do |plugin|
          plugin.name = 'spina_test'
          plugin.namespace = 'spina_test'
          plugin.settings = {
            test_setting: { wysiwyg: '<div></div>' },
            foobar: :string
          }
        end
      end
    end
  end
end

module Spina
  class PluginTest < ActionDispatch::IntegrationTest
    setup do
      @plugin = ::Spina::Plugin.find_by(namespace: 'spina_test')
    end

    test 'registration must have a name' do
      assert_raise 'Missing plugin name' do
        ::Spina::Plugin.register {}
      end
    end

    test 'registration must have a namespace' do
      assert_raise 'Missing plugin namespace' do
        ::Spina::Plugin.register do |plugin|
          plugin.name = 'foo'
        end
      end
    end

    test 'registration with settings creates a setting class' do
      assert(true, ::Spina::SpinaTest::Setting.new.is_a?(Spina::Setting))
      assert(true, Spina::SpinaTest::Setting.new.respond_to?(:"test_setting="))
      assert(true, Spina::SpinaTest::Setting.new.respond_to?(:"foobar="))
    end
  end
end
