require "rails_helper"

RSpec.describe CreateUser do
  subject { described_class }

  # let(:interactors)
  # {[
  #   { class: MakeNewUser, double: double("make_new_user") },
  #   { class: EncryptPassword, double: double("encrypt_password") },
  #   { class: CreateConfirmationToken, double: double("create_confirmation_token") },
  #   { class: SendNewUserConfirmation, double: double("send_new_user_confirmation") }
  # ]}
  let(:user) { create(:unconfirmed_user) }

  let(:user_params) do
    {:user =>
      { name: user.name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
      }
    }
  end

  let(:make_new_user) { double("make_new_user") }
  let(:encrypt_password) { double("encrypt_password") }
  let(:create_confirmation_token) { double("create_confirmation_token") }
  let(:send_new_user_confirmation) { double("send_new_user_confirmation") }

  before(:example) do
    # interactors.each do |interactor|
    #   allow(interactor.fetch(:class)).to receive(:new).and_return(interactor.fetch(:double))
    # end

    allow(MakeNewUser).to receive(:new).and_return(make_new_user)
    allow(make_new_user).to receive(:run!)
    allow(make_new_user).to receive(:context)
  end

  describe ".call" do
    # interactors.each do |interactor|
    #   it "calls the #{interactor.fetch(:class).name} interactor" do
    #     expect(interactor.fetch(:double)).to receive(:run!)
    #     subject.call
    #   end
    # end

    it "calls the MakeNewUser interactor" do
      expect(make_new_user).to receive(:run!).with(user_params)
      subject.call
    end
  end
end
