require 'test_helper'

module Spina
  module Admin
    class SettingsControllerTest < ActionController::TestCase
      setup do
        @routes = ::Spina::Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        @plugin = ::Spina::Plugin.find_by(namespace: 'spina_test')
        @controller.stubs(:current_spina_user).returns(@user)
      end

      test 'editing produces the correct forms' do
        get :edit, params: { plugin: 'spina_test' }
        assert_template :edit
        assert assigns(:setting).is_a?(Spina::SpinaTest::Setting)
        assert assigns(:setting).test_setting == '<div></div>'
      end

      test 'updating updates the settings' do
        patch :update, params: { plugin: 'spina_test', setting: { foobar: 'baz' } }

        assert Spina::SpinaTest::Setting.first.foobar == 'baz'
      end

    end
  end
end
