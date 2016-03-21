module Spina
  module Reviews
    module Admin
      class ReviewsController < Spina::Admin::AdminController

        before_filter :set_breadcrumb

        layout "spina/admin/website"

        def show
          @review = Review.find(params[:id])
        end

        def index
          @reviews = Review.ordered
          @average_rating = Review.average('rating') || 0
        end

        def new
          add_breadcrumb "Nieuwe beoordeling", spina.new_reviews_admin_review_path

          @review = Review.new
        end

        def edit
          @review = Review.find(params[:id])
          add_breadcrumb @review.name
        end

        def create
          @review = Review.new(review_params)

          add_breadcrumb "Nieuwe beoordeling"
          if @review.save
            redirect_to spina.reviews_admin_reviews_path, notice: "Beoordeling is aangemaakt."
          else
            render :new
          end
        end

        def update
          @review = Review.find(params[:id])

          add_breadcrumb @review.name

          if @review.update_attributes(review_params)
            redirect_to spina.reviews_admin_reviews_path, notice: "Beoordeling van #{@review.name} opgeslagen"
          else
            render :edit
          end
        end

        def destroy
          @review = Review.find(params[:id])
          @review.destroy
          redirect_to spina.reviews_admin_reviews_path, notice: "De beoordeling is verwijderd."
        end

        def confirm
          @review = Review.find(params[:id])
          @review.confirmed_at = Date.today
          @review.save
          redirect_to spina.reviews_admin_reviews_path
        end

        private

        def set_breadcrumb
          add_breadcrumb 'Beoordelingen', spina.reviews_admin_reviews_path
        end

        def review_params
          params.require(:review).permit(:name, :rating, :created_at, :explanation, :confirmed_at)
        end

      end
    end
  end
end
