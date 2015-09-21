class ShopsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :index, :approve, :reject]
before_action :check_and_set_premium_url, only: [:edit, :show]
before_action :set_products, only: [:show]
before_action :find_shop, only: [:like, :dislike]

  def create
    @shop = current_user.shops.new(shop_params)
    create!
    @shop.opening_hours.last.try(:destroy)
  end

  def new
    @auto_select = true
    new!
  end

  def edit
    if any_redirect_to_premium_path(resource)
      redirect_to edit_shop_premium_url(resource.premium_account.url), status: 301
    else
      @auto_select = false
      edit!
    end
  end

  def show
    if any_redirect_to_premium_path(resource)
      redirect_to shop_premium_url(resource.premium_account.url), status: 301
    else
      @categories = @shop.scategories
      @work_hours = @shop.opening_hours.order("day_work= 6, day_work= 5, day_work= 4, day_work= 3,
                                               day_work= 2, day_work= 1, day_work= 0 ");
      @reviews = resource.reviews
      @review = Review.new
      @products = Product.all
      @this_is_current_user_shop = current_user.shops.where(id: @shop.id) if current_user
      @products = resource.products
      show!
    end
  end

  def update
    if resource.premium_account.present? && resource.premium_account.status
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
      redirect_to controlpanel_shop_premium_url(@shop.premium_account.url), status: 301
    else
      @products = Product.all
    end
    @offer_rooms = @shop.offer_rooms
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
    render json: Scategory.all.where("name ILIKE ?", "%#{params[:search]}%").as_json(only: [:name, :id])
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
      params.require(:shop).permit(:name, :image,  :description,   :address,
                                   :mobile_phones, :business_name, :business_email,
                                   :categories,    :cover_image,   :telephone,
                                   opening_hours_attributes:  [:id, :day_work, :start_work,
                                                               :end_work, :_destroy],
                                   scategory_shops_attributes: [:id, :shop_id, :scategory_id,
                                                               :_destroy])
    end
end

