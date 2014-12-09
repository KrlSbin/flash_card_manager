Rails.application.routes.draw do
  root "trainer#index"

  put "trainer", to: "trainer#check_translate"

  resources :cards
end
