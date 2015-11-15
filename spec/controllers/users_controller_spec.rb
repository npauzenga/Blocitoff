require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:unconfirmed_user) }

  describe "POST #create" do
    let(:interactor_input) do
      {:user =>
        { name: user.name,
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
      allow(CreateUser).to receive(:call).with(interactor_input).
        and_return(interactor_context)
    end

    context "when valid params are given" do
      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, interactor_input
      end

      it "returns http status 201" do

      end

      it "renders view X" do

      end
    end

    context "when email is not provided" do

    end


  end
end
