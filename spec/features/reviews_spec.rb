require 'rails_helper'
require 'support/offers_helper'
RSpec.configure do |config|
  config.include OffersHelper
end

feature "Reviews" do

  background do
    @owner        = create(:user)
    @user         = create(:user)

    @shop         = create(:shop, user: @owner)
    @product      = create(:product, shop: @shop)

    @random_rate  = "star-"+rand(1..5).to_s
    @paragraph    = Faker::Lorem.paragraph
  end

  scenario 'a shop', js: true do
    login_as(@user, scope: :user, run_callbacks: false)
    visit shop_path(@shop)

    review_count = @shop.reviews.size
    create_offer(@random_rate, @paragraph)

    expect(page).to have_content @paragraph
    expect(review_count+1).to eq @shop.reviews.count
  end

  scenario 'a product', js: true do
    login_as(@user, scope: :user, run_callbacks: false)
    visit shop_product_path(shop_id: @shop, id: @product)

    review_count = @product.reviews.size
    create_offer(@random_rate, @paragraph)

    expect(page).to have_content @paragraph
    expect(review_count+1).to eq @product.reviews.count
  end

end
