class ShopsController < InheritedResources::Base
before_action :set_products, only: [:show]
before_action :find_shop, only: [:upvote, :downvote]
before_action :authenticate_user!, except: [:show, :index]

  
  
  def create
    @user = current_user
  	@products = @user.shops.new(shop_params)
  	
      if @products.save

        ShopMailer.shop_created(@user).deliver
      end  
    redirect_to @products  
  end

  def upvote
    @shop.upvote_by current_user
    redirect_to :back
  end 

  def downvote
    @shop.downvote_by current_user
    redirect_to :back
  end 


  private
    
    def find_shop
      @shop = Shop.find(params[:id])
    end 

    def set_products
      @products = Product.where(shop_id: resource.id)
    end

    def shop_params
      params.require(:shop).permit(:name, :image, :description)
    end
end

