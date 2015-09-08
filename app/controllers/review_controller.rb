class ReviewController < ApplicationController
  def create
    current_user.reviews.create(review_params)
    redirect_to :back
  end

  private

    def review_params
      params.require(:review).permit(:content, :rate_point, :reviewable_id, :reviewable_type)
    end
end
