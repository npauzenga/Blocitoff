require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_static_email) { create(:user, email: "test@test.com") }
  let(:user_invalid_email) { build(:user, email: "xxx") }

  describe "validations" do
    it "rejects an invalid email address" do
      expect(user_invalid_email.save).to eq false
    end

    it "rejects a duplicate email address" do
      user_static_email
      build(:user, email: "test@test.com").should_not be_valid
    end
  end
end
