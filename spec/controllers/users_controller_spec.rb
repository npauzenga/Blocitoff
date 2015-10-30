require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:unconfirmed_user) }

  describe "email confirmation" do
    it "sends a confirmation email when user registers" do
      expect {
        UserMailer.registration_confirmation(user).deliver_now
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end
end
