require "rails_helper"

RSpec.describe FindPasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user, reset_token: nil, reset_digest: nil) }

    before(:example) do
      CreatePasswordResetToken.call(user: user)
    end

    context "when user and correct token provided" do
      subject do
        described_class.call(user: user, id: user.reset_token)
      end

      it "returns successfully" do
        is_expected.to be_a_success
      end
    end

    context "when user is nil" do
      subject do
        described_class.call(user: nil, id: user.reset_token)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end

    context "when token is incorrect" do
      subject do
        described_class.call(user: user, id: "HastThouConsideredTheTetrapod")
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
