module ApplicationHelper
	def unreviewed_by?(current_user, id, type)
		current_user.shops.where(id: @shop.id).blank? && current_user.reviews.where(reviewable_id: id, reviewable_type: type).blank?
	end

	def generate_path_for(object, action, options={})
		if object.premium_account.present? && object.premium_account.status
			if action.eql? "show"
			 shop_premium_path(object.premium_account.url)
			elsif action.eql? "edit"
			 edit_shop_premium_path(object.premium_account.url)
			elsif action.eql? "controlpanel"
				if options[:product].present?
					controlpanel_shop_premium_path(id: object.premium_account.url, product: options[:product])
				else
				 controlpanel_shop_premium_path(object.premium_account.url)
			 	end
		 	elsif action.eql? "show_offer"
		 		show_offers_premium_path(premium_path: object.premium_account.url, product_id: options[:product_id], user_id: options[:user_id])
			end
		else
			if action.eql? "show"
				shop_path(object)
			elsif action.eql? "edit"
				edit_shop_path(object)
			elsif action.eql? "controlpanel"
				if options[:product].present?
					controlpanel_shop_path(id: object, product: options[:product])
				else
					controlpanel_shop_path(object)
				end
			elsif action.eql? "show_offer"
	 			show_offers_path(shop_id: object, product_id: options[:product_id], user_id: options[:user_id])
			end
		end
	end

	def generate_product_path(object, action)
		if object.shop.premium_account.present? && object.shop.premium_account.status
			if action.eql? "show"
				 product_premium_path(premium_path: object.shop.premium_account.url, id: object)
			elsif action.eql? "edit"
				 edit_product_premium_path(premium_path: object.shop.premium_account.url, id: object)
			elsif action.eql? "new"
				 new_product_premium_path(premium_path: object.shop.premium_account.url)
			elsif action.eql? "form"
				[object.shop, object]
			elsif action.eql? "destroy"
				product_premium_path(premium_path: object.shop.premium_account.url, id: object)
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
			elsif action.eql? "destroy"
				shop_product_path(shop_id: object.id, id: object)
			end
		end
	end

		def generate_product_2_path(object, action)
		if object.premium_account.present?  && object.premium_account.status
			new_product_premium_path(premium_path: object.premium_account.url)
		else
			new_shop_product_path(shop_id: object)
		end
	end
end
