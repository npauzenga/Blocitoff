require "rails_helper"

RSpec.describe CreatePasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject(:create_reset_token) do
        described_class.call(user: user)
      end

      it "sets the user's reset token" do
        expect { create_reset_token }.to change { user.reset_token }
      end

      it "sets the user's reset_digest" do
        expect { create_reset_token }.to change { user.reset_digest }
      end

      it "sets the user's reset_sent_at" do
        expect { create_reset_token }.to change { user.reset_sent_at }
      end
    end

    context "when user is invalid" do
      subject(:create_reset_token) do
        described_class.call(user: nil)
      end

      it "fails" do
        expect(create_reset_token).to be_a_failure
      end
    end

    context "when reset token isn't properly assigned" do
      subject(:create_reset_token) do
        described_class.call(user: user)
      end

      before(:example) do
        allow(Encryptor).to receive(:generate_token).and_return(nil)
      end

      it "fails" do
        expect(create_reset_token).to be_a_failure
      end
    end
  end
end
