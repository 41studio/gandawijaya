require 'rails_helper'

feature "User" do
  background do
    @user = create(:user)
    @user_build = build(:another_user)
  end

  scenario "create user", js: true do
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

  scenario 'log in', js: true do
    visit '/users/sign_in'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content("Signed in successfully.")

  end

  scenario 'log out', js: true do
    login_as(@user, :scope => :user, :run_callbacks => false)
    visit '/'
    click_on "Sign Out"
    expect(current_path).to eq root_path
    expect(page).to have_content("Signed out successfully.")
  end

end
