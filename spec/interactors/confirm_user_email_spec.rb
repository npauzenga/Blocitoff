require "rails_helper"

RSpec.describe ConfirmUserEmail do
  describe ".call" do
    let(:user) { create(:unconfirmed_user) }

    context "when successful" do
      subject do
        described_class.call(id: user.confirm_token)
      end

      it "finds the user" do
        expect(subject.user).to eq(user)
      end

      it "sets email_confirmed to true" do
        expect(subject.user.email_confirmed).to be(true)
      end

      it "sets confirm_digest to nil" do
        expect(subject.user.confirm_digest).to be(nil)
      end

      it "sets confirm_token to nil" do
        expect(subject.user.confirm_token).to be(nil)
      end

      it "saves the user's new attributes" do
        expect(subject.user).to be_persisted
      end
    end

    context "when unsuccesful" do
      subject do
        described_class.call(id: "...but our princess is in another castle")
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
