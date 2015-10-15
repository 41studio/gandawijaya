module ApplicationHelper
	def unreviewed_by?(id, type)
		current_user.reviews.where(reviewable_id: id, reviewable_type: type).blank? if current_user
	end

	def generate_path_for(object, action, options={})
		if object.account_status
			if action.eql? "show"
			 shop_premium_path(object.url)
			elsif action.eql? "edit"
			 edit_shop_premium_path(object.url)
			elsif action.eql? "controlpanel"
				if options[:product].present?
					controlpanel_shop_premium_path(id: object.url, product: options[:product])
				else
				 controlpanel_shop_premium_path(object.url)
			 	end
		 	elsif action.eql? "show_offer"
		 		show_offers_premium_path(premium_path: object.url, product_id: options[:product_id], user_id: options[:user_id])
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
		if object.shop.account_status
			if action.eql? "show"
				 product_premium_path(premium_path: object.shop.url, id: object)
			elsif action.eql? "edit"
				 edit_product_premium_path(premium_path: object.shop.url, id: object)
			elsif action.eql? "new"
				 new_product_premium_path(premium_path: object.shop.url)
			elsif action.eql? "form"
				[object.shop, object]
			elsif action.eql? "destroy"
				product_premium_path(premium_path: object.shop.url, id: object)
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
		if object.account_status
			new_product_premium_path(premium_path: object.url)
		else
			new_shop_product_path(shop_id: object)
		end
	end
end
