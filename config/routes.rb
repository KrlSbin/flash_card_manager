Rails.application.routes.draw do
  root "trainer#index"

  put "trainer", to: "trainer#check_translation"

  resources :cards
end
