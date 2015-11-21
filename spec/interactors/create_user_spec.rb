require "rails_helper"

RSpec.describe CreateUser do
  subject { described_class }

  let(:user) { create(:unconfirmed_user) }

  let(:interactor_context) do
    Interactor::Context.new(errors: :val, user: user)
  end

  let(:make_new_user) { double("make_new_user") }
  let(:encrypt_password) { double("encrypt_password") }
  let(:create_confirmation_token) { double("create_confirmation_token") }
  let(:send_new_user_confirmation) { double("send_new_user_confirmation") }

  before(:example) do
    allow(MakeNewUser).to receive(:new).and_return(make_new_user)
    allow(make_new_user).to receive(:run!)
    allow(make_new_user).to receive(:run)
    allow(make_new_user).to receive(:context)

    allow(EncryptPassword).to receive(:new).and_return(encrypt_password)
    allow(encrypt_password).to receive(:run!)
    allow(encrypt_password).to receive(:run)
    allow(encrypt_password).to receive(:context)

    allow(CreateConfirmationToken).to receive(:new).
      and_return(create_confirmation_token)
    allow(create_confirmation_token).to receive(:run!)
    allow(create_confirmation_token).to receive(:run)
    allow(create_confirmation_token).to receive(:context)

    allow(SendNewUserConfirmation).to receive(:new).
      and_return(send_new_user_confirmation)
    allow(send_new_user_confirmation).to receive(:run!)
    allow(send_new_user_confirmation).to receive(:run)
    allow(send_new_user_confirmation).to receive(:context)
  end

  describe ".call" do
    it "calls the MakeNewUser interactor" do
      expect(make_new_user).to receive(:run!)
      subject.call(interactor_context)
    end

    it "calls the EncryptPassword interactor" do
      expect(encrypt_password).to receive(:run!)
      subject.call(interactor_context)
    end

    it "calls the CreateConfirmationToken interactor" do
      expect(create_confirmation_token).to receive(:run!)
      subject.call(interactor_context)
    end

    it "calls the SendNewUserConfirmation interactor" do
      expect(send_new_user_confirmation).to receive(:run!)
      subject.call(interactor_context)
    end
  end
end
