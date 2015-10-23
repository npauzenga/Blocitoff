require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:unconfirmed_user) { build(:user) }
  
  describe "email confirmation" do
    it "sends a confirmation email when user registers" do
      allow(UserMailer)
        .to receive(:registration_confirmation)
        .with(unconfirmed_user)
        .and_return(double(deliver_now: true))

      expect(UserMailer).to receive(:registration_confirmation)
      unconfirmed_user.save
    end

    xit "does not allow an unconfirmed user to sign in" do
      #TODO
    end
  end
end
