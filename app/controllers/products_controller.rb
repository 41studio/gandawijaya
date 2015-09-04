class ProductsController < InheritedResources::Base
before_action :set_shop_from_params, only: [:new]
before_action :find_product, only: [:upvote, :downvote]
before_action :set_shop, only: [:show, :edit]
before_action :set_galleries, only: [:show]
before_action :authenticate_user!, except: [:show, :product_disccusion]

  def product_disccusion
    @product = Product.find(params[:id])
    @galleries = resource.galleries
    @comments = @product.comments
  end  

  def create
    @product = current_user.products.build(product_params)
    
     if @product.save
      redirect_to @product
    else
      render 'new'
    end    
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

   @comments = @product.comments



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
      @shop = Shop.find(params[:shop_id])
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

