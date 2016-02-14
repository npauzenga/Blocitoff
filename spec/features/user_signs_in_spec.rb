require "rails_helper"

feature "User signs in" do
  let(:user) { create(:confirmed_user) }

  scenario "Successfully" do
    visit root_path
    within ".navbar" do
      click_link "Sign In"
    end
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    within "form" do
      click_button "Sign In"
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content(user.name)
  end
end
