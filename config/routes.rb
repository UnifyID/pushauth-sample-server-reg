Rails.application.routes.draw do
  root "application#home"

  get "login", to: "sessions#new"

  post "login", to: "sessions#create"

  get "2fa", to: "sessions#init_2fa"

  get "2fa/check", to: "sessions#check_2fa"

  patch "2fa/finalize", to: "sessions#finalize_2fa"

  delete "logout", to: "sessions#destroy"

  get "restricted", to: "application#restricted"
end
