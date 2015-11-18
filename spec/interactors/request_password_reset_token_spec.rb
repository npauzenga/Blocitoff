require "rails_helper"

RSpec.describe RequestPasswordResetToken do
  subject { described_class }

  let(:user) { create(:unconfirmed_user) }

  let(:find_password_reset_user) { double("find_password_reset_user") }
  let(:create_password_reset_token) { double("create_password_reset_token") }
  let(:send_password_reset_email) { double("send_password_reset_email") }

  before(:example) do
    allow(FindPasswordResetUser).to receive(:new).
      and_return(find_password_reset_user)
    allow(find_password_reset_user).to receive(:run!)
    allow(find_password_reset_user).to receive(:run)
    allow(find_password_reset_user).to receive(:context)

    allow(CreatePasswordResetToken).to receive(:new).
      and_return(create_password_reset_token)
    allow(create_password_reset_token).to receive(:run!)
    allow(create_password_reset_token).to receive(:run)
    allow(create_password_reset_token).to receive(:context)

    allow(SendPasswordResetEmail).to receive(:new).
      and_return(send_password_reset_email)
    allow(send_password_reset_email).to receive(:run!)
    allow(send_password_reset_email).to receive(:run)
    allow(send_password_reset_email).to receive(:context)
  end

  describe ".call" do
    it "calls the FindPasswordResetUser interactor" do
      expect(find_password_reset_user).to receive(:run!)
      subject.call
    end

    it "calls the CreatePasswordResetToken interactor" do
      expect(create_password_reset_token).to receive(:run!)
      subject.call
    end

    it "calls the SendPasswordResetEmail interactor" do
      expect(send_password_reset_email).to receive(:run!)
      subject.call
    end
  end
end
