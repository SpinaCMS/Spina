module Spina
  PagesController.class_eval do

    private

    def reviews
      Review.ordered.confirmed
    end
    helper_method :reviews

    def reviews_page_path
      Page.where(view_template: 'reviews').first.try(:materialized_path)
    end
    helper_method :reviews_page_path

    def average_rating
      Review.average('rating') || 0
    end
    helper_method :average_rating

    def rating_count
      Review.count
    end
    helper_method :rating_count

  end
end