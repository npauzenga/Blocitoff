Rails.application.routes.draw do
  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :todos,           only: [:new, :create, :show]

  resources :users, except: [:new] do
    member do
      get :confirm_email
    end
  end

  root to: "welcome#index"
end
