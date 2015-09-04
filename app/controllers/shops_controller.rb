class ShopsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :index]
before_action :check_and_set_premium_url, only: [:edit, :show]
before_action :set_products, only: [:show]

  def create
  	@shop = current_user.shops.new(shop_params)
  	create!
  end

  def update
    if resource.premium_account.present?
      update! do |success, failure|
        success.html { redirect_to update_shop_premium_url(resource.premium_account.url) }
      end
    else
      update!
    end
  end

  def show
    @review = Review.new
    @reviews = resource.reviews
    @this_is_current_user_shop = current_user.shops.where(id: @shop.id) if current_user
    @products = Product.where(shop_id: resource.id)
    show!
  end

  private
    def check_and_set_premium_url
      if params[:premium_path]
        premium_account = PremiumAccount.select(:shop_id).where(url: params[:premium_path]).first
        if premium_account.present?
          @shop = Shop.find premium_account.shop_id
        else
          @products = collection
          redirect_to shops_path, notice: "maaf url tidak ada" and return
        end
      end
    end

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description)
    end
end

