require "rails_helper"

feature "User signs in" do
  let(:user) { create(:user, email_confirmed: true) }

  scenario "Successfully" do
    visit root_path
    within ".nav" do
      click_link "Sign In"
    end
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    within "form" do
      click_button "Sign In"
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content("User Profile!")
  end
end
