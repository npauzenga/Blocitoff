require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:confirmed_user) }

  describe "GET #new" do
    context "when successful" do
      it "returns http status 200" do
        get :new
        expect(response).to have_http_status(200)
      end

      it "renders the #new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    let(:params) do
      { sign_in: { email: user.email, password: user.password } }
    end

    let(:interactor_input) do
      { email: params[:sign_in][:email], password: params[:sign_in][:password] }
    end

    let(:context) { double(:context, success?: true, user: user) }

    before(:example) do
      allow(AuthenticateUser).to receive(:call).with(interactor_input).
        and_return(context)
    end

    context "when valid credentials are given" do
      it "calls the CreateUser interactor" do
        expect(AuthenticateUser).to receive(:call)
        post :create, params
      end

      it "returns http status 200" do
        post :create, params
        expect(response).to have_http_status(302)
      end

      it "redirects to user profile" do
        expect(post :create, params).to redirect_to(user_path(user))
      end
    end

    it "flashes success" do
      delete :destroy
      expect(flash[:notice]).to be_present
    end

    context "when invalid params are passed" do
      before(:example) do
        allow(context).to receive(:success?) { false }
      end

      it "redirects to #new" do
        expect(post :create, params).to render_template :new
      end

      it "flashes an error" do
        post :create, params
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let(:interactor_input)   { { session: session } }
    let(:interactor_context) { double(:context, success?: true) }

    before do
      allow(LogOutUser).to receive(:call).with(interactor_input).
        and_return(interactor_context)

      session[:user_id] = user.id
    end

    context "when successful" do
      it "calls the LogOutUser interactor" do
        expect(LogOutUser).to receive(:call)
        delete :destroy
      end

      it "redirects to root" do
        expect(delete :destroy).to redirect_to(sign_in_path)
      end

      it "flashes success" do
        delete :destroy
        expect(flash[:notice]).to be_present
      end
    end

    context "when unsuccessful" do
      before(:example) do
        allow(interactor_context).to receive(:success?) { false }
      end

      it "flashes error" do
        delete :destroy
        expect(flash[:error]).to be_present
      end
    end
  end
end
