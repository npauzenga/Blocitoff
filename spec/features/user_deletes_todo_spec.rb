require "rails_helper"

feature "User deletes todo" do
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
    fill_in "Create Todo", with: "Meet up with the team"
    click_button "Save"
    page.find(".todo-checkbox").click

    expect(page).not_to have_content("Meetup with the team")
  end
end
