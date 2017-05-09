module Spina
  class PagesController < Spina::ApplicationController
    include Spina::Frontend

    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    before_action :current_spina_user_can_view_page?, except: [:robots]

    helper_method :page

    def homepage
      render_with_template(page)
    end

    private

      def current_spina_user_can_view_page?
        raise ActiveRecord::RecordNotFound if page.nil? || !page.live?

        current_spina_user.present?
      end

      def render_404
        render file: "#{Rails.root}/public/404.html", status: 404
      end

  end
end
