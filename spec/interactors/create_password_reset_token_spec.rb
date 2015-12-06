require "rails_helper"

RSpec.describe CreatePasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user, reset_token: nil) }

    context "when successful" do
      subject do
        described_class.call(user: user)
      end

      it "sets the user's reset token" do
        expect(subject.user.reset_token).to eq(subject.raw)
      end

      it "sets the user's reset_digest" do
        expect(subject.user.reset_digest).to eq(subject.enc)
      end

      it "sets the user's reset_sent_at" do
        expect(subject.user.reset_sent_at).to be_an(ActiveSupport::TimeWithZone)
      end
    end

    context "when there isn't a valid user" do
      subject do
        described_class.call(user: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
