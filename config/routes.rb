Rails.application.routes.draw do
  get    "sign_up"   => "users#new", as: "sign_up"
  get    "sign_in"   => "sessions#new"
  post   "sign_in"   => "sessions#create"
  delete "sign_out"  => "sessions#destroy"

  resources :user_confirmation, only:   [:show], as: "submit_confirmation"
  resources :users,             except: [:new]
  resources :password_resets,   only:   [:new, :create, :edit, :update]

  resources :users do
    resources :todos, only: [:create]
  end

  resources :todos, only: [:destroy]

  root to: "welcome#index"
end
