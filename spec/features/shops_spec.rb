require 'rails_helper'

feature "Shops" do
  background do
    @user         = create(:user)
    @another_shop = build(:another_shop)

    @shop         = create(:shop, user: @user)
    @another_user = create(:user)

    @category     = create(:scategory)
    @category1    = create(:scategory)
    @category2    = create(:scategory)
  end

  scenario 'create shop', js: true do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/shops/new'

    shop_count = Shop.count
    fill_in 'shop_name', with: @shop.name
    fill_in 'shop_address', with: @shop.address
    fill_in 'shop_telephone', with: @shop.telephone
    fill_in 'shop_mobile_phones', with: @shop.mobile_phones
    fill_in 'search-category', with: @category.name
    find('.ui-menu-item').click
    click_button 'Create Shop'

    expect(shop_count+1).to eq Shop.count
    expect(page).to have_content('Shop was successfully created.')
  end

  scenario 'update shop', js: true do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit shop_path(@shop)
    click_link 'Edit'

    fill_in 'shop_name', with: @another_shop.name
    fill_in 'shop_address', with: @another_shop.address
    fill_in 'shop_telephone', with: @another_shop.telephone
    fill_in 'shop_mobile_phones', with: @shop.mobile_phones
    fill_in 'search-category', with: @category.name
    find('.ui-menu-item').click
    click_button 'Update Shop'

    expect(page).to have_content('Shop was successfully updated.')
  end

  scenario 'like shop' do
    like_count = @shop.get_upvotes.size
    login_as(@another_user, :scope => :user, :run_callbacks => false)
    visit shop_path(@shop)

    click_on 'Like'
    expect(like_count+1).to eq @shop.get_upvotes.size
  end

end
