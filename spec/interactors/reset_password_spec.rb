require "rails_helper"

RSpec.describe ResetPassword do
  subject { described_class }

  let(:user) { create(:unconfirmed_user) }

  let(:update_password) { double("update_password") }
  let(:login_user) { double("login_user") }

  before(:example) do
    allow(UpdatePassword).to receive(:new).and_return(update_password)
    allow(update_password).to receive(:run!)
    allow(update_password).to receive(:run)
    allow(update_password).to receive(:context)

    allow(LoginUser).to receive(:new).and_return(login_user)
    allow(login_user).to receive(:run!)
    allow(login_user).to receive(:run)
    allow(login_user).to receive(:context)
  end

  describe ".call" do
    it "calls the UpdatePassword interactor" do
      expect(update_password).to receive(:run!)
      subject.call
    end

    it "calls the LoginUser interactor" do
      expect(login_user).to receive(:run!)
      subject.call
    end
  end
end
