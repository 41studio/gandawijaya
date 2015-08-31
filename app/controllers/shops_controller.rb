class ShopsController < InheritedResources::Base
before_action :set_products, only: [:show]

  private

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description)
    end
end

