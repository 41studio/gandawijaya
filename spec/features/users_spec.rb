require 'rails_helper'

feature "User" do
  background do
    @user = create(:user)
    @user_build = build(:another_user)
  end

  scenario "create" do
    visit "/users/sign_up"

    fill_in "user_first_name", with: @user_build.first_name
    fill_in "user_last_name", with: @user_build.last_name
    fill_in "user_email", with: @user_build.email
    fill_in "user_password", with: @user_build.password
    fill_in "user_password_confirmation", with: @user_build.password
    check "user_term_of_user"

    click_button "Sign up"

    expect(page).to have_content("A message with a confirmation link has been sent
                                  to your email address. Please follow the link to
                                  activate your account.")
    expect(current_path).to eq root_path
  end

  scenario 'log in' do
    visit '/users/sign_in'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content("Signed in successfully.")

  end

  scenario 'log out' do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/'
    click_on "Sign Out"
    expect(current_path).to eq root_path
    expect(page).to have_content("Signed out successfully.")
  end

  scenario 'edit' do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit profile_pages_path

    click_link 'edit'
    fill_in "user_username"     , with: @user.username
    fill_in "user_first_name"   , with: @user.first_name
    fill_in "user_last_name"    , with: @user.last_name
    fill_in "user_email"        , with: @user.email
    fill_in "user_address"      , with: @user.address
    fill_in "user_handphone"    , with: @user.handphone

    select(rand(1950..2005), from: 'user_birthday_1i')
    within '#user_birthday_2i' do
      find("option[value='"+rand(1..12).to_s+"']").click
    end
    within '#user_birthday_3i' do
      find("option[value='"+rand(1..29).to_s+"']").click
    end

    fill_in "user_password", with: @user.password
    fill_in "user_password_confirmation", with: @user.password

    click_on 'Update User'

    expect(page).to have_content 'Your account has been updated successfully.'
  end

end
