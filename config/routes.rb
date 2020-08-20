Rails.application.routes.draw do
  root "application#home"

  resource :users, only: [:new, :create] do
    post "trust"

    get "post_signup"
  end

  get "login", to: "sessions#new"

  post "login", to: "sessions#create"

  get "mfa", to: "sessions#init_mfa"

  get "mfa/check", to: "sessions#check_mfa"

  patch "mfa/finalize", to: "sessions#finalize_mfa"

  delete "logout", to: "sessions#destroy"

  get "restricted", to: "application#restricted"
end
