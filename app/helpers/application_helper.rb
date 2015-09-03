module ApplicationHelper
  def unreviewed_by?(current_user)
    current_user.shops.where(id: @shop.id).blank? && current_user.reviews.where(reviewable_id: @shop.id).blank?
  end

  def generate_path_for(object, action)
    if object.premium_account.present?
      if action.eql? "show"
       shop_premium_path(object.premium_account.url)
     elsif action.eql? "edit"
       edit_shop_premium_path(object.premium_account.url)
     end
    else
      if action.eql? "show"
        shop_path(object)
      elsif action.eql? "edit"
        edit_shop_path(object)
      end
    end
  end

  def generate_product_path(object, action)
    if object.shop.premium_account.present?
      if action.eql? "show"
       product_premium_path(premium_path: object.shop.premium_account.url, id: object)
     elsif action.eql? "edit"
       edit_product_premium_path(premium_path: object.shop.premium_account.url, id: object)
     elsif action.eql? "new"
       new_product_premium_path(premium_path: object.shop.premium_account.url)
     elsif action.eql? "form"
      [object.shop, object]
     end
    else
      if action.eql? "show"
        shop_product_path(shop_id: object.shop, id: object)
      elsif action.eql? "edit"
        edit_shop_product_path(shop_id: object.shop, id: object)
      elsif action.eql? "new"
        new_shop_product_path(shop_id: object.shop)
      elsif action.eql? "form"
        [object.shop, object]
      end
    end
  end
end
