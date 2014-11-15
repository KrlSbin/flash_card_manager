Rails.application.routes.draw do
  get "simple/index"

  get "/", to: "simple#index"

end
