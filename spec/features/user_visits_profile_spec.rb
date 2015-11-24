require "rails_helper"

feature "User visits profile" do
  let(:user) { create(:confirmed_user) }

  before do
    visit root_path
    within ".nav" do
      click_link "Sign In"
    end
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    within "form" do
      click_button "Sign In"
    end
  end

  scenario "Visiting root redirects to profile" do
    visit root_path
    expect(page).to have_content(user.name)
  end
end
