require "spec_helper"

feature "User deletes todo" do
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
    click_link ""

    expect(page).not_to have_content("Meetup with the team")
  end
end
