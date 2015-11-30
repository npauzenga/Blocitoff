require "rails_helper"

RSpec.describe User do
  let(:user_static_email) do
    create(:confirmed_user, email: "test@test.com")
  end

  let(:user_unconfirmed_valid)  { create(:unconfirmed_user) }
  let(:user_invalid_email)      { build(:unconfirmed_user, email: "xxx") }

  context "attributes" do
    %w(name password_hash password_salt email_confirmed
       confirm_digest reset_digest reset_sent_at).each do |attribute|
      it { is_expected.to have_attribute attribute }
    end

    it "sets email_confirmed to false" do
      expect(user_unconfirmed_valid.email_confirmed).to be false
    end
  end

  context "validations" do
    it { is_expected.to validate_presence_of :email }

    it "validates the uniqueness of an email address" do
      original = user_static_email
      duplicate = build(:unconfirmed_user, email: original.email)
      expect(duplicate.valid?).to be false
    end

    it "validates the format of an email address" do
      expect(user_invalid_email.valid?).to be false
    end
  end

  context "relationships" do
    it { is_expected.to have_many :todos }
  end
end
