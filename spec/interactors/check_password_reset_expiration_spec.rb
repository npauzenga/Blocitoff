require  "rails_helper"

RSpec.describe CheckPasswordResetExpiration do
  describe ".call" do
    let(:user_expired_token) { create(:confirmed_user,
                                      reset_sent_at: 1.day.ago) }

    let(:user_valid_token)   { create(:confirmed_user,
                                      reset_sent_at: Time.now) }

    context "when reset has not expired" do
      subject(:context) do
        described_class.call(user: user_valid_token)
      end

      it "succeeds" do
        binding.pry
        expect(context).to be_a_success
      end
    end

    context "when reset has expired" do

    end
  end
end
