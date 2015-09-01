class ShopsController < InheritedResources::Base
before_action :set_products, only: [:show]
before_action :authenticate_user!, except: [:show, :index]
  
  def create
  	@products = current_user.shops.create(shop_params)
  	create!
  end


  private

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description)
    end
end

