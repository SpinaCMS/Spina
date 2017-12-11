module Spina
  module Admin
    class MediaPickerController < AdminController

      def show
        @images = Image.sorted.page(params[:page])

        if params[:page].present?
          render :infinite_scroll
        else
          render :show
        end
      end

      def select
        @image = Image.find(params[:image_id])
      end

    end
  end
end