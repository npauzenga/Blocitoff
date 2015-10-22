Rails.application.routes.draw do
  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"

  resources :todos, only: [:new, :create, :show]
  resources :users

  root to: "welcome#index"
end
