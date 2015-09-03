class ProductsController < InheritedResources::Base
before_action :set_shop_from_params, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show]
before_action :authenticate_user!

  def new
    @product = @shop.products.new
  end

  def create
    @product = current_user.products.create(product_params)
    create!
  end

  def show
    @review = Review.new
    @reviews = resource.reviews
  end

  private
    def set_shop_from_params
      @shop = Shop.find(params[:shop_id]) if params[:shop_id].present?
      if params[:premium_path].present?
        @shop = Shop.find 5
      end
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

