class ProductsController < InheritedResources::Base
before_action :set_shop_from_params, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show]

  private
    def set_shop_from_params
      @shop = Shop.find(params[:shop_id])
    end

    def set_shop
      @shop = resource.shop
    end

    def set_galleries
      @galleries = resource.galleries
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :shop_id, galleries_attributes: [:id, :image, :_destroy])
    end
end
