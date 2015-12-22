require "rails_helper"

RSpec.describe FindPasswordResetUser do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject do
        described_class.call(email: user.email)
      end

      it "assigns a user" do
        expect(subject.user).to be_a(User)
      end
    end

    context "when unsuccessful" do
      subject do
        described_class.call(email: "test@fake.com")
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
