class ShopsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :index, :approve, :on_progress, :searching]
before_action :check_and_set_premium_url, only: [:edit, :show, :controlpanel]
before_action :set_products, only: [:show]
before_action :find_shop, only: [:like]

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
    @shop = current_user.shops.find @shop
    if any_redirect_to_premium_path(resource)
      redirect_to edit_shop_premium_url(resource.premium_account_url), status: 301
    else
      @auto_select = false
      edit!
    end
  end

  def show
    if any_redirect_to_premium_path(resource)
      redirect_to shop_premium_url(resource.premium_account_url), status: 301
    else
      @categories = @shop.scategories
      @work_hours = @shop.opening_hours.not_contain_nil_hour.order_by_day
      @reviews    = resource.reviews
      @review     = Review.new
      @products   = Product.all
      @products   = resource.products
      impressionist(resource, "view shop")
      @this_is_current_user_shop = current_user.shops.include? resource if current_user
      show!
    end
  end

  def update
    if resource.premium_account.present? && resource.premium_account.status
      update! do |success, failure|
        success.html { redirect_to shop_premium_url(resource.premium_account_url) }
      end
    else
      update!
    end
  end

  def controlpanel
    if any_redirect_to_premium_path(@shop)
      redirect_to controlpanel_shop_premium_url(@shop.premium_account_url), status: 301
    end
      @shop = current_user.shops.find @shop
      @products = @shop.products

    if params[:product].present?
      product = Product.find params[:product]
      @offer_rooms = product.offer_rooms
    else
      @offer_rooms = @shop.offer_rooms.order(:product_id)
    end
  end

  def approve
    @shop = Shop.find(params[:id])
    @shop.approved!
    redirect_to :back
  end

  def on_progress
    @shop = Shop.find(params[:id])
    @shop.on_progress!
    redirect_to :back
  end

  def like
    @shop.like_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "shops/like_dislike.js" }
    end
  end

  def autocompletecategory
    render json: Scategory.all.where("name ILIKE ?", "%#{params[:search]}%").as_json(only: [:name, :id])
  end

  def searching
    @search = params[:search_by].eql?("shop") ? Shop.search_shop(params[:search_text], params[:search_by]) : Product.search_product(params[:search_text])
    # @search = Shop.search_shop(params[:search_text], params[:search_by])
    @search_par = {search_by: params[:search_by], search_text: params[:search_text]}

    # render json: { result: @search, count: @search.length }
  end

  def my_shop
    @shops = current_user.shops
  end

  private

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

