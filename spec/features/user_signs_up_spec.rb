require "rails_helper"

feature "User signs up" do
  scenario "Successfully"do
    visit root_path
    within ".navbar" do
      click_link "Sign Up"
    end
    fill_in "Name", with: "Ted Danson"
    fill_in "Password", with: "helloworld"
    fill_in "Confirmation", with: "helloworld"
    fill_in "Email", with: "tdanson@remembercheers.com"

    within "form" do
      click_button "Sign Up"
    end
    expect(current_path).to eq sign_in_path
    expect(page).
      to have_content("Thanks! Please check your email to complete sign up")
  end
end

feature "User confirms account" do
  scenario "Successfully" do
    # TODO
  end
end
