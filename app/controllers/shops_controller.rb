class ShopsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :index, :approve, :reject]
before_action :check_and_set_premium_url, only: [:edit, :show]
before_action :set_products, only: [:show]
before_action :find_shop, only: [:upvote, :downvote]

  def create
    @shop = current_user.shops.new(shop_params)
    create!
  end

  def approve
    # ambil shop yang dituju dan tambahkan kode untuk merubah status shop menjadi approved
    @shop = Shop.find(params[:id])
    @shop.approved!
    redirect_to :back
  end

  def reject
    @shop = Shop.find(params[:id])
    @shop.rejected!
    redirect_to :back
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
    @products = resource.products
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
        Shop.find PremiumAccount.with_url(params[:premium_path]).shop_id
      else
        Shop.find params[:id]
      end
  end

  private
    def check_and_set_premium_url
      if params[:premium_path]
        premium_account = PremiumAccount.with_url(params[:premium_path])
        if premium_account.present?
          @shop = Shop.find premium_account.shop_id
        else
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
      params.require(:shop).permit(:name, :image, :description, :address, :telephone, :mobile_phones, :business_name, :business_email, :categories, :cover_image)
    end
end

