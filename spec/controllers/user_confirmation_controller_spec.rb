require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    context "when successful" do
      let(:user)   { create(:unconfirmed_user) }
      let(:params) { { id: user.id.to_s } }
      #
      # let(:interactor_input) do
      #   { id: user.confirm_token }
      # end

      let(:interactor_context) do
        Interactor::Context.new(errors: :val)
      end

      before(:example) do
        allow(ConfirmUserEmail).to receive(:call).with(id: user.confirm_token)
          .and_return(interactor_context)
      end

      it "calls the ConfirmUserEmail interactor" do
        expect(ConfirmUserEmail).to receive(:call)
        get :show, params
      end

      it "returns http status 200" do

      end

      it "shows a welcome message" do

      end

      it "renders the #show template" do

      end
    end

    context "when unsuccessful" do
      it "shows an error" do

      end

      it "redirects to root" do

      end
    end
  end
end
