class ShopsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :index, :approve, :reject]
before_action :check_and_set_premium_url, only: [:edit, :show]
before_action :set_products, only: [:show]
before_action :find_shop, only: [:like, :dislike]

  def create
    @shop = current_user.shops.new(shop_params)
    create!
  end

  def edit
    if any_redirect_to_premium_path(resource)
      redirect_to edit_shop_premium_path(resource.premium_account.url), status: 301
    else
      edit!
    end
  end

  def show
    if any_redirect_to_premium_path(resource)
      redirect_to shop_premium_path(resource.premium_account.url), status: 301
    else
      @review = Review.new
      @reviews = resource.reviews
      @products = Product.all
      @this_is_current_user_shop = current_user.shops.where(id: @shop.id) if current_user
      @products = resource.products
      show!
    end
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
    @shop =
      if params[:premium_path]
        Shop.find PremiumAccount.with_url(params[:premium_path]).shop_id
      else
        Shop.find params[:id]
      end
    if any_redirect_to_premium_path(@shop)
      redirect_to controlpanel_shop_premium_path(@shop.premium_account.url), status: 301
    else
      @products = Product.all
    end
  end

  def approve
    @shop = Shop.find(params[:id])
    @shop.approved!
    redirect_to :back
  end

  def reject
    @shop = Shop.find(params[:id])
    @shop.rejected!
    redirect_to :back
  end

  def like
    @shop.like_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "shops/like_dislike.js" }
    end
  end

  def dislike
    @shop.dislike_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "shops/like_dislike.js" }
    end
  end

  def autocompletecategory
    render json: Scategory.search(params[:search], fields: [:name]).map(&:name)
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
      params.require(:shop).permit(:name, :image, :description, :address, :telephone, :mobile_phones, :business_name, :business_email, :categories, :cover_image, opening_hours_attributes: [:id, :day_work, :start_work, :end_work, :_destroy])
    end
end

