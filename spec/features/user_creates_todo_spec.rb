require "rails_helper"

feature "User creates a todo" do
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
    fill_in "Description", with: "Meet up with the team"
    click_button "Save"
    expect(page).to have_content("Meet up with the team")
  end

  scenario "With description missing" do
    visit root_path
    within ".nav" do
      click_link "Sign In"
    end
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    within "form" do
      click_button "Sign In"
    end
    click_button "Save"
    expect(page).to have_content("Your TODO was not saved")
  end
end
