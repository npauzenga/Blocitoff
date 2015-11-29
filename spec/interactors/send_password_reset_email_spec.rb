require "rails_helper"

RSpec.describe SendPasswordResetEmail do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    subject(:send_email) do
      described_class.call(user: user)
    end

    before do
      CreatePasswordResetToken.call(user: user)
      ActionMailer::Base.deliveries.clear
    end

    context "when successful" do
      it "sends a password reset email" do
        send_email
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end
end
