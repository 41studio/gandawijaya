module ApplicationHelper
  def unreviewed_by?(current_user)
    current_user.shops.where(id: @shop.id).blank? && current_user.reviews.where(reviewable_id: @shop.id).blank?
  end
end
