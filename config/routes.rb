Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  root to: "trainer#index"
  put "trainer", to: "trainer#check_translation"

  get "set_current_deck", to: "users#set_current_deck"

  resources :user_sessions
  resources :cards, only: [:index]
  resources :users

  resources :decks do
    resources :cards
  end

  get "login" => "user_sessions#new"
  post "logout" => "user_sessions#destroy"
end
