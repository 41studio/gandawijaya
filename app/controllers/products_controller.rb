class ProductsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :product_disccusion]
before_action :check_and_set_premium_url, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show]
before_action :find_product, only: [:like]

  def show
    if any_redirect_to_premium_path(@shop)
      redirect_to product_premium_url(premium_path: @shop.premium_account.url, id: resource), status: 301
    else
      @review = Review.new
      @reviews = resource.reviews
      impressionist(resource, "view product")
      if current_user
        @offers = resource.offer_rooms.where(user_id: current_user.id).first.try(:offers)
        @user_product = current_user.products.find_by(id: resource.id).present?
      end
      show!
    end
  end

  def new
    @product = @shop.products.new
    if any_redirect_to_premium_path(@shop)
      redirect_to new_product_premium_url(premium_path: @shop.premium_account.url), status: 301
    end
  end

  def edit
    @product = current_user.products.find params[:id]
    if any_redirect_to_premium_path(resource.shop)
      redirect_to edit_product_premium_url(premium_path: resource.shop.premium_account.url, id: resource), status: 301
    else
      edit!
    end
  end

  def update
    if resource.shop.premium_account.present? && resource.shop.premium_account.status
      update! do |success, failure|
        success.html { redirect_to product_premium_url(premium_path: resource.shop.premium_account.url, id: resource) }
      end
    else
      update! do |success, failure|
        success.html { redirect_to shop_product_url(shop_id: resource.shop, id: resource) }
      end
    end
  end

  def create
    @product = current_user.products.new(product_params)
    shop = Shop.find params[:product][:shop_id]
    if shop.approved?
      @product.approved!
    end
    if shop.premium_account.present? && shop.premium_account.status
      create! do |success, failure|
        success.html { redirect_to product_premium_url(premium_path: shop.premium_account.url, id: @product) }
      end
    else
      create! do |success, failure|
        success.html { redirect_to shop_product_url(shop_id: shop, id: @product) }
      end
    end
  end

  def like
    @product.like_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "products/like_dislike.js" }
    end
  end

  private
    def find_product
      @product = Product.find(params[:id])
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

