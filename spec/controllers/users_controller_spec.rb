require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:unconfirmed_user) }

  describe "GET #new" do
    context "when successful" do
      it "assigns new User to @user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

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
    let(:params) { { user: interactor_input.fetch(:user_params) } }

    let(:interactor_input) do
      { user_params: {
        name:                  user.name,
        email:                 user.email,
        password:              user.password,
        password_confirmation: user.password_confirmation }
      }
    end

    let(:interactor_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(CreateUser).to receive(:call).with(interactor_input).
        and_return(interactor_context)
    end

    context "when valid params are given" do
      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, params
      end

      it "returns http status 302" do
        post :create, params
        expect(response).to have_http_status(302)
      end

      it "redirects to sign in" do
        expect(post :create, params).to redirect_to(sign_in_path)
      end
    end

    context "when invalid invalid params are passed" do
      before(:example) do
        allow(interactor_context).to receive(:success?) { false }
      end

      it "redirects to sign up" do
        expect(post :create, params).to redirect_to(sign_up_path)
      end
    end
  end

  describe "GET #show" do
    let(:confirmed_user_1) { create(:confirmed_user) }
    let(:current_user)     { create(:confirmed_user) }
    let(:params)           { { id: confirmed_user_1.id } }
    let(:session)          { { user_id: current_user.id } }

    let(:arguments) do
      { id:         params.fetch(:id).to_s,
        current_id: session.fetch(:user_id) }
    end

    let(:context) { double(:context, success?: true, user: confirmed_user_1) }

    before(:example) do
      allow(ShowUser).to receive(:call).with(arguments).
        and_return(context)
    end

    context "when user logged in" do
      it "calls the ShowUser interactor" do
        expect(ShowUser).to receive(:call)
        get :show, params, session
      end

      it "assigns valid User to @user" do
        get :show, params, session
        expect(assigns(:user)).to be(confirmed_user_1)
      end

      it "returns http status 200" do
        get :show, params, session
        expect(response).to have_http_status(200)
      end

      it "renders the #show view" do
        get :show, params, session
        expect(response).to render_template :show
      end
    end

    context "when user not logged in" do
      before do
        session[:user_id] = nil
      end

      it "redirects to sign in" do
        expect(get :show, params, session).to redirect_to(sign_in_path)
      end
    end
  end
end
