Rails.application.routes.draw do
  get "home/index"
  devise_for :users,
             skip: %i[registrations passwords],
             controllers: {
               omniauth_callbacks: "users/github_callbacks",
               sessions: "users/sessions"
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # get "/", to: "login#index"
  root "home#index"

  get "/invite_ids", to: "invite_ids#show", as: :invite_ids
  post "/invite_ids", to: "invite_ids#create"

  get "/profile", to: "profiles#edit", as: :profile
  patch "/profile", to: "profiles#update"

  get "/profile/url", to: "profile_urls#edit", as: :profile_url
  patch "/profile/url", to: "profile_urls#update"

  namespace :admin do
    resources :users, only: %i[index] do
      member do
        patch :confirm
      end
    end
  end
end
