require "rails_helper"

RSpec.describe CheckPasswordResetExpiration do
  describe ".call" do
    let(:user_expired_token) do
      create(:confirmed_user, reset_sent_at: 1.day.ago)
    end

    let(:user_valid_token) do
      create(:confirmed_user, reset_sent_at: Time.zone.now)
    end

    context "when reset has not expired" do
      subject do
        described_class.call(user: user_valid_token)
      end

      it "succeeds" do
        is_expected.to be_a_success
      end
    end

    context "when reset has expired" do
      subject do
        described_class.call(user: user_expired_token)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
