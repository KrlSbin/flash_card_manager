Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  root to: "trainer#index"
  put "trainer", to: "trainer#check_translation"

  resources :user_sessions

  resources :users do
    resources :cards, only: [:index]
  end

  resources :users do
    resources :decks, only: [:index]
  end

  resources :decks do
    resources :cards
  end

  get "login" => "user_sessions#new"
  post "logout" => "user_sessions#destroy"
end
