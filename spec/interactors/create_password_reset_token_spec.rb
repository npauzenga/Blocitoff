require "rails_helper"

RSpec.describe CreatePasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject(:create_reset_token) do
        described_class.call(user: user)
      end

      it "sets the user's reset token" do
        original_token = user.reset_token
        create_reset_token
        new_token = user.reset_token
        expect(original_token).not_to eq(new_token)
      end

      it "sets the user's reset_digest" do
        original_digest = user.reset_digest
        create_reset_token
        new_digest = user.reset_digest
        expect(original_digest).not_to eq(new_digest)
      end

      it "sets the user's reset_sent_at" do
        original_reset_sent_at = user.reset_sent_at
        create_reset_token
        new_reset_sent_at = user.reset_sent_at
        expect(original_reset_sent_at).not_to eq(new_reset_sent_at)
      end
    end
  end
end
