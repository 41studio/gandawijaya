class ProductsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :product_disccusion]
before_action :set_shop_from_params, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show, :product_disccusion]
before_action :find_product, only: [:like, :dislike]

  def show
    if any_redirect_to_premium_path(@shop)
      redirect_to product_premium_path(premium_path: @shop.premium_account.url, id: resource), status: 301
    else
      @review = Review.new
      @reviews = resource.reviews
      impressionist(resource, "view product")
      @impression_count = resource.impressionist_count(:filter=>:all)
      show!
    end
  end

  def new
    @product = @shop.products.new
    if any_redirect_to_premium_path(@shop)
      redirect_to new_product_premium_path(premium_path: @shop.premium_account.url), status: 301
    end
  end

  def edit
    if any_redirect_to_premium_path(resource.shop)
      redirect_to edit_product_premium_path(premium_path: resource.shop.premium_account.url, id: resource), status: 301
    else
      edit!
    end
  end

  def create
    @product = current_user.products.new(product_params)
    shop = Shop.find params[:product][:shop_id]
    if shop.approved?
      @product.approved!
    end
    create!
  end

  def product_disccusion
    @product = Product.find(params[:id])
    @comments = @product.comments
  end

  def create_comment
   @product = Product.find(params[:comment][:product_id])
   @user = @product.user
   @comment = current_user.comments.new
   @comment.comment = params[:comment][:comment]
   @comment.commentable = @product
     if @comment.save
        CommentMailer.comment_created(@user, current_user, @comment ).deliver
      end

   redirect_to product_disccusion_path(@product)
  end

  def like
    @product.like_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "products/like_dislike.js" }
    end
  end

  def dislike
    @product.dislike_by current_user
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render template: "products/like_dislike.js" }
    end
  end

  private
    def find_product
      @product = Product.find(params[:id])
    end

    def set_shop_from_params
      if params[:shop_id].present?
        @shop = Shop.find(params[:shop_id])
      elsif params[:premium_path].present?
        premium_account = PremiumAccount.select(:shop_id).where(url: params[:premium_path]).first
         if premium_account.present?
          @shop = Shop.find premium_account.shop_id
        else
          redirect_to shops_path, notice: "maaf url tidak ada" and return
        end
      end
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

