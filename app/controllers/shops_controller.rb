class ShopsController < InheritedResources::Base
before_action :set_products, only: [:show]

  def create
    @shop = current_user.shops.create(shop_params)
    create!
  end

  def show
    @review = Review.new
    show!
  end

  private

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description)
    end
end

