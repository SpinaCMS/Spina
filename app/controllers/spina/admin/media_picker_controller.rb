module Spina
  module Admin
    class MediaPickerController < AdminController

      def show
        @images = Image.page(params[:page])

        if params[:selected_ids].present?
          ids = params[:selected_ids].map(&:to_i).join(', ')
          @images = @images.order(Arel.sql("CASE WHEN id IN(#{ids}) THEN 0 ELSE 1 END, created_at DESC"))
        else
          @images = @images.sorted
        end

        render params[:page].present? ? :infinite_scroll : :show
      end

      def select
        if params[:multiple]
          @images = Image.where(id: params[:image_ids])
        else 
          @image = Image.find(params[:image_id])
        end
      end

    end
  end
end
