class ProductsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :product_disccusion]
before_action :check_and_set_premium_url, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show]
before_action :find_product, only: [:like]

  def show
    if any_redirect_to_premium_path(@shop)
      redirect_to product_premium_url(premium_path: @shop.url, id: resource), status: 301
    else
      @review  = Review.new
      @reviews = resource.reviews
      impressionist(resource, "view product")
      if user_signed_in?
        @offers       = resource.offer_rooms.find_by(user_id: current_user.id).try(:offers)
        @user_product = current_user.products.find_by(id: resource.id).present?
      end
      show!
    end
  end

  def new
    @shop    = current_user.shops.find @shop
    @product = @shop.products.new

    if any_redirect_to_premium_path(@shop)
      redirect_to new_product_premium_url(premium_path: @shop.url), status: 301
    end
  end

  def edit
    @shop = current_user.shops.find @shop
    if any_redirect_to_premium_path(@shop)
      redirect_to edit_product_premium_url(premium_path: @shop.url, id: @shop), status: 301
    else
      edit!
    end
  end

  def update
    if resource.shop.account_status
      update! do |success, failure|
        success.html { redirect_to product_premium_url(premium_path: resource.shop.url, id: resource) }
      end
    else
      update! do |success, failure|
        success.html { redirect_to shop_product_url(shop_id: resource.shop, id: resource) }
      end
    end
  end

  def create
    @product = current_user.products.new(product_params)
    @shop    = Shop.find params[:product][:shop_id]

    if @shop.account_status
      create! do |success, failure|
        success.html { redirect_to product_premium_url(premium_path: @shop.url, id: @product) }
      end
    else
      create! do |success, failure|
        success.html { redirect_to shop_product_url(shop_id: @shop, id: @product) }
      end
    end

    @product.approved! if @shop.approved? && @product.valid?

  end

  def like
    @product.like_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js   { render "products/like_dislike.js" }
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
      params.require(:product).permit(:name, :price, :description, :shop_id,
                                      galleries_attributes: [:id, :image, :_destroy])
    end
end

