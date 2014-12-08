Rails.application.routes.draw do
  root "trainer#index"

  get "/trainer", to: "trainer#check_translate"

  resources :cards
end
