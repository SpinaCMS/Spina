require 'test_helper'

module Spina
  module Admin
    class AdminControllerTest < ActionController::TestCase
      setup do
        class ::TestingController < AdminController
          def hello
            render :nothing => true
          end
        end

        @routes = ::Spina::Engine.routes

        ActionController::Routing::Routes.draw do |map|
          map.hello '', :controller => 'testing', :action => 'hello'
        end
      end

      teardown do
        Object.send(:remove_const, :TestingController)
      end

      context 'when user is not logged in' do
        setup do
          @controller = TestingController.new
        end

        test "redirect unauthorized users to login page" do
          get :hello
          assert_template layout: 'spina/login'
        end
      end
    end
  end
end
