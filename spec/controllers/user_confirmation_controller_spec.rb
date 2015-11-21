require "rails_helper"

RSpec.describe UserConfirmationController, type: :controller do
  describe "GET #show" do
    let(:user)      { create(:unconfirmed_user) }
    let(:params)    { { id: user.confirm_token } }
    let(:arguments) { { id: user.confirm_token.to_s } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      allow(ConfirmUserEmail).to receive(:call).with(arguments).
        and_return(context)
    end

    context "when successful" do
      it "calls the ConfirmUserEmail interactor" do
        expect(ConfirmUserEmail).to receive(:call)
        get :show, params
      end

      it "returns http status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "renders the #show template" do
        get :show, params
        expect(response).to render_template :show
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false) }

      before(:example) do
        allow(ConfirmUserEmail).to receive(:call).
          and_return(context)
      end

      it "redirects to root" do
        expect(get :show, params).to redirect_to(root_url)
      end
    end
  end
end
