class ShopsController < InheritedResources::Base
before_action :set_products, only: [:show]
before_action :find_shop, only: [:upvote, :downvote]
before_action :authenticate_user!, except: [:show, :index]

  def create
    @shop = current_user.shops.new(shop_params)
    create!
  end

  def upvote
    @shop.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @shop.downvote_by current_user
    redirect_to :back
  end

  def show
    @review = Review.new
    @reviews = resource.reviews
    @products = Product.all
    @this_is_current_user_shop = current_user.shops.where(id: @shop.id) if current_user
    @products = Product.where(shop_id: resource.id)
    show!
  end

  def update
    if resource.premium_account.present?
      update! do |success, failure|
        success.html { redirect_to shop_premium_url(resource.premium_account.url) }
      end
    else
      update!
    end
  end

    def controlpanel
    @products = Product.all
    @shop =
      if params[:premium_path]
        Shop.find PremiumAccount.where(url: params[:premium_path]).first.shop_id
      else
        Shop.find params[:id]
      end
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

    def find_shop
      @shop = Shop.find(params[:id])
    end

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description, :address)
    end
end

