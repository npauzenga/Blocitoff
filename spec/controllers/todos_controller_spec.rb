require "rails_helper"
include SessionsHelper

RSpec.describe TodosController, type: :controller do
  let(:user) { create(:confirmed_user) }

  before do
    # log the user in
    session[:user_id] = user.id
  end

  describe "POST #create" do
    let(:todo) { create(:todo, user_id: user.id) }

    let(:context) do
      double(:context, success?: true, user: user, todo: todo)
    end

    let(:todo_params)      { { description: todo.description } }
    let(:interactor_input) { { user: current_user, todo_params: todo_params } }
    let(:params)           { { todo: todo_params, user_id: user.id } }

    before(:example) do
      allow(CreateTodo).to receive(:call).with(interactor_input).
        and_return(context)
    end

    context "when successful" do
      it "calls the CreateTodo interactor" do
        expect(CreateTodo).to receive(:call)
        post :create, params
      end

      it "returns http status 302" do
        post :create, params
        expect(response).to have_http_status(302)
      end

      it "redirects to user profile" do
        expect(post :create, params).to redirect_to(user)
      end

      it "flashes success" do
        post :create, params
        expect(flash[:notice]).to be_present
      end
    end

    context "when unsuccessful" do
      before(:example) do
        allow(context).to receive(:success?) { false }
      end

      it "redirects to user profile" do
        expect(post :create, params).to redirect_to(user)
      end

      it "flashes error" do
        post :create, params
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let(:todo)             { create(:todo, user_id: user.id) }
    let(:params)           { { id: todo.id } }
    let(:interactor_input) { { todo_id: params.fetch(:id).to_s } }

    let(:context) do
      double(:context, success?: true, user: user, todo: todo)
    end

    before(:example) do
      allow(DestroyTodo).to receive(:call).with(interactor_input).
        and_return(context)
    end

    context "when successful" do
      it "calls the DestroyTodo interactor" do
        expect(DestroyTodo).to receive(:call)
        delete :destroy, params
      end

      it "flashes success" do
        delete :destroy, params
        expect(flash[:notice]).to be_present
      end
    end

    context "when when html response is requested" do
      it "renders html" do
        delete :destroy, params
        expect(response.headers["Content-Type"]).
          to eq "text/html; charset=utf-8"
      end
    end

    context "when js response is requested" do
      it "renders js" do
        xhr :delete, :destroy, params
        expect(response.headers["Content-Type"]).
          to eq "text/javascript; charset=utf-8"
      end
    end

    context "when unsuccessful" do
      before(:example) do
        allow(context).to receive(:success?) { false }
      end

      it "flashes an error" do
        delete :destroy, params
        expect(flash[:error]).to be_present
      end
    end
  end
end
