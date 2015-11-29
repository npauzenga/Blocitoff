require "rails_helper"

RSpec.describe UpdatePassword do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    let(:user_params) do
      { password: "newpass", password_confirmation: "newpass" }
    end

    let(:salt) { Encryptor.generate_salt }

    context "when successful" do
      subject do
        described_class.call(user_params: user_params, user: user)
      end

      it "succeeds" do
        is_expected.to be_a_success
      end

      it "updates password_hash" do
        expect(subject.user.password_hash).
          to eq(Encryptor.digest_password(user_params[:password],
                                          user.password_salt))
      end

      it "updates password_salt" do
        expect { subject }.to change { user.password_salt }
      end

      it "sets reset_digest to nil" do
        expect(subject.user.reset_digest).to be_nil
      end
    end

    context "when unsuccessful" do
      subject do
        described_class.call(user_params: user_params, user: user)
      end

      before do
        user_params[:password_confirmation] = "TheseAreNotTheDroids..."
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
