class PagesController < ApplicationController
  def dashboard
    @shops = Shop.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
  end
end
