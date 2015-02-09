Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  root to: "trainer#index"
  put "trainer", to: "trainer#check_translation"

  resources :cards
  resources :users
  resources :user_sessions

  get "login" => "user_sessions#new"
  post "logout" => "user_sessions#destroy"
end
