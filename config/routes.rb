Rails.application.routes.draw do
  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"

  resources :user_confirmation, only: [:update], as: "submit_confirmation"
  resources :user_confirmation, only: [:show]
  resources :todos, only: [:new, :create, :show]
  resources :users, except: [:new]

  root to: "welcome#index"
end
