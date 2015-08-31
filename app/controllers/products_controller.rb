class ProductsController < InheritedResources::Base
before_action :set_shop, only: [:new]

  private

    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :shop_id)
    end
end

