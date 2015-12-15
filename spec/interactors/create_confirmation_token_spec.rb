require "rails_helper"

RSpec.describe CreateConfirmationToken do
  describe ".call" do
    let(:user) { create(:unconfirmed_user, confirm_token: nil) }

    context "when successful" do
      subject do
        described_class.call(user: user)
      end

      it "sets user's confirmation token" do
        expect(subject.user.confirm_token).to eq(subject.raw)
      end

      it "updates user's confirm_digest attribute" do
        expect(subject.user.confirm_digest).to eq(subject.enc)
      end
    end

    context "when invalid user provided" do
      subject do
        described_class.call(user: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
