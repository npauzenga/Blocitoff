require "rails_helper"

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) do
    create(:confirmed_user, reset_token: SecureRandom.urlsafe_base64.to_s)
  end

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
    let(:params)    { { password_reset: { email: user.email } } }
    let(:arguments) { { email: user.email } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      allow(RequestPasswordResetToken).to receive(:call).with(arguments).
        and_return(context)
    end

    context "when valid params are given" do
      it "calls the RequestPasswordResetToken interactor" do
        expect(RequestPasswordResetToken).to receive(:call)
        post :create, params
      end

      it "returns http status 302" do
        post :create, params
        expect(response).to have_http_status(302)
      end

      it "redirects to sign in" do
        expect(post :create, params).to redirect_to(root_url)
      end
    end

    context "when invalid invalid params are passed" do
      let(:context) { double(:context, success?: false) }

      it "renders to #new template" do
        expect(post :create, params).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    context "when successful" do
      let(:params)    { { id: user.reset_token, email: user.email } }

      let(:arguments) do
        { user: User.find_by(email: params[:email]),
          id:   user.reset_token }
      end

      let(:context) { double(:context, success?: true, user: user) }

      before(:example) do
        allow(VerifyPasswordResetUser).to receive(:call).with(arguments).
          and_return(context)
      end

      it "returns http status 200" do
        get :edit, params
        expect(response).to have_http_status(200)
      end

      it "renders the #new template" do
        get :edit, params
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    let(:verify_pw_input) do
      { user: User.find_by(email: params[:email]),
        id:   user.reset_token }
    end

    let(:params) do
      { user:  reset_pw_input.fetch(:user_params),
        email: user.email,
        id:    user.reset_token }
    end

    let(:user_params) do
      { password:              user.password,
        password_confirmation: user.password_confirmation }
    end

    let(:reset_pw_input) { { user_params: user_params, user: user } }

    before(:example) do
      allow(VerifyPasswordResetUser).to receive(:call).with(verify_pw_input).
        and_return(verify_pw_context)

      allow(UpdatePassword).to receive(:call).with(reset_pw_input).
        and_return(update_pw_context)
    end

    context "when successful" do
      let(:verify_pw_context) { double(:context, success?: true, user: user) }
      let(:update_pw_context) { double(:context, success?: true, user: user) }

      it "calls the ResetPassword interactor" do
        expect(UpdatePassword).to receive(:call)
        patch :update, params
      end

      it "returns http status 302" do
        patch :update, params
        expect(response).to have_http_status(302)
      end

      it "redirects to sign in" do
        expect(patch :update, params).to redirect_to(sign_in_path)
      end
    end

    context "when unsuccessful" do
      let(:verify_pw_context) { double(:context, success?: true, user: user) }
      let(:update_pw_context) { double(:context, success?: false, user: user) }

      it "renders the #edit template" do
        expect(patch :update, params).to render_template(:edit)
      end
    end
  end
end
