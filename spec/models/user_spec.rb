require "rails_helper"

RSpec.describe User, type: :model do
  let(:unconfirmed_user) { build(:user) }
  let(:user_static_email) { create(:user, email: "test@test.com") }
  let(:user_invalid_email) { build(:user, email: "xxx") }

  describe "validations" do
    it "rejects an invalid email address" do
      expect(user_invalid_email.save).to eq false
    end

    it "rejects a duplicate email address" do
      user_static_email
      expect(build(:user, email: "test@test.com")).to_not be_valid
    end
  end

  describe "email confirmation" do
    it "sends a confirmation email when user registers" do
      allow(UserMailer)
        .to receive(:registration_confirmation)
        .with(unconfirmed_user)
        .and_return(deliver_now: true)

      expect(UserMailer).to receive(:registration_confirmation)
      unconfirmed_user.save
    end

    xit "does not allow an unconfirmed user to sign in" do
      #TODO
    end
  end
end
