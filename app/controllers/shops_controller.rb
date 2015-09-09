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


  def update
    if resource.premium_account.present?
      update! do |success, failure|
        success.html { redirect_to shop_premium_url(resource.premium_account.url) }
      end
    else
      update!
    end
  end

  def downvote
    @shop.downvote_by current_user
    redirect_to :back
  end


  private

    def find_shop
      @shop = Shop.find(params[:id])
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

