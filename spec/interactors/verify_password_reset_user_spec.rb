require "rails_helper"

RSpec.describe VerifyPasswordResetUser do
  subject { described_class }

  let(:user) { create(:unconfirmed_user) }

  let(:interactor_context) do
    Interactor::Context.new(errors: :val, user: user)
  end

  let(:find_password_reset_token) { double("find_password_reset_token") }

  let(:check_password_reset_expiration) do
    double("check_password_reset_expiration")
  end

  before(:example) do
    allow(FindPasswordResetToken).to receive(:new).
      and_return(find_password_reset_token)
    allow(find_password_reset_token).to receive(:run!)
    allow(find_password_reset_token).to receive(:run)
    allow(find_password_reset_token).to receive(:context)

    allow(CheckPasswordResetExpiration).to receive(:new).
      and_return(check_password_reset_expiration)
    allow(check_password_reset_expiration).to receive(:run!)
    allow(check_password_reset_expiration).to receive(:run)
    allow(check_password_reset_expiration).to receive(:context)
  end

  describe ".call" do
    it "calls the FindPasswordResetToken interactor" do
      expect(find_password_reset_token).to receive(:run!)
      subject.call(interactor_context)
    end

    it "calls the CheckPasswordResetExpiration interactor" do
      expect(check_password_reset_expiration).to receive(:run!)
      subject.call(interactor_context)
    end
  end
end
