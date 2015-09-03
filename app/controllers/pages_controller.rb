class PagesController < ApplicationController
  def dashboard
    @shops = Shop.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
    @shops = Shop.where(accept_shop: true)
    @products = Product.where(accept_product: true)
  end
end
