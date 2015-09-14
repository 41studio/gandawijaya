class ProductsController < InheritedResources::Base
before_action :authenticate_user!, except: [:show, :product_disccusion]
before_action :set_shop_from_params, only: [:new]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show, :product_disccusion]
before_action :find_product, only: [:upvote, :downvote]

  def show
    @review = Review.new
    @reviews = resource.reviews
    impressionist(resource, "view product")
    @impression_count = resource.impressionist_count(:filter=>:all)
    show!
  end

  def new
    @product = @shop.products.new
  end

  def create
    @product = current_user.products.new(product_params)
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

  def upvote
    @product.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @product.downvote_by current_user
    redirect_to :back
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
          @products = collection
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

