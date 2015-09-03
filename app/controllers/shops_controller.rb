class ShopsController < InheritedResources::Base
# before_action :set_products, only: [:show]
before_action :authenticate_user!, except: [:show, :index]

  def create
  	@products = current_user.shops.create(shop_params)
  	create!
  end

  def show
    if params[:premium_path]
      premium_account = PremiumAccount.select(:shop_id).where(url: params[:premium_path]).first
      if premium_account.present?
        @shop = Shop.find premium_account.shop_id
      else
        @products = collection
        redirect_to shops_path, notice: "maaf url tidak ada" and return
      end
    end
    @review = Review.new
    @reviews = resource.reviews
    @this_is_current_user_shop = current_user.shops.where(user_id: @shop.id) if current_user
    @products = Product.where(shop_id: resource.id)
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

