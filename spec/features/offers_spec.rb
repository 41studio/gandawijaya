require 'rails_helper'

feature "Offers" do

  background do
    @user         = create(:user)
    @owner        = create(:another_user)
    @shop         = create(:shop, user: @owner)
    @product      = create(:product, shop: @shop)

    @offer_room   = create(:offer_room, user: @user, shop: @shop, product: @product)
    @offer        = create(:offer, offer_room: @offer_room, user: @user)

    @offer_content= Faker::Lorem.paragraph
    @offer_reply  = Faker::Lorem.paragraph
    @offer_count  = @shop.offer_rooms.size
  end

  scenario 'create by unsigned_in user', js: true do
    visit shop_product_path(shop_id: @shop, id: @product)

    click_on 'Send an offer'
    fill_in 'Email'         , with: @user.email
    fill_in 'Your name'     , with: @user.first_name + " " +@user.last_name
    fill_in 'Mobile number' , with: @user.handphone
    fill_in 'Content'       , with: @offer_content

    find('.btn-submit-offer').click

    expect(page).to have_content 'Offer succesfully created'
  end

  scenario 'create by signed_in user', js: true do
    login_as(@user, scope: :user, run_callbacks: false)
    visit shop_product_path(shop_id: @shop, id: @product)

    click_on 'Send an offer'
    fill_in 'Content'       , with: @offer_content

    find('.btn-submit-offer').click

    expect(page).to have_content(@offer_content)
  end

  scenario 'can be replied and seen by owner a from controlpanel', js: true do
    login_as(@owner, scope: :user, run_callbacks: false)
    visit controlpanel_shop_path(@shop)

    expect(page).to have_content(@offer_room.product.name)
    expect(page).to have_content(@offer.user.username)

    #user can see detai offer by clicking link and modal will show
    click_link '('+@offer_room.user.email+')'
    expect(page).to have_content(@offer.content)

    #user reply
    fill_in 'Content'       , with: @offer_reply
    find('.btn-submit-offer').click

    expect(page).to have_content(@offer_reply)
  end

  scenario 'can be replied and seen by user from landing page', js: true do
    login_as(@user, scope: :user, run_callbacks: false)
    visit profile_pages_path

    expect(page).to have_content @offer.content
    expect(page).to have_content @offer_room.product.name

    click_link @offer.content
    fill_in 'Content'       , with: @offer_reply
    click_on 'Create Offer', wait: 10

    expect(page).to have_content(@offer_reply)

  end

end
