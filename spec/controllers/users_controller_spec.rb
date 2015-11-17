require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:unconfirmed_user) }

  describe "POST #create" do
    let(:params) { { user: interactor_input.fetch(:user_params) } }

    let(:interactor_input) do
      { user_params: {
          name: user.name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password_confirmation
        }
      }
    end

    let(:interactor_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(CreateUser).to receive(:call).with(interactor_input)
        .and_return(interactor_context)
    end

    context "when valid params are given" do
      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, params
      end

    #   # 200 because we're redirecting to sign_in?
    #   it "returns http status 200" do
    #     expect(response).to have_http_status(200)
    #     post :create, interactor_input
    #   end
    #
    #   it "renders view sessions#new" do
    #     expect(post :create, interactor_input).to redirect_to(sign_in_path)
    #   end
    end
    #
    # # it'll still call CreateUser.call but this has been tested?
    # context "when email is not provided" do
    #   it "redirects to sign_up" do
    #     interactor_input[:user][:email] = nil
    #     expect(post :create, interactor_input).to redirect_to(sign_up_path)
    #   end
    # end
    #
    # context "when password is not provided" do
    #   it "redirects to sign_up" do
    #   end
    # end
    #
    # context "when password confirmation is not provided" do
    #   it "redirects to sign_up" do
    #   end
    # end


  end
end
