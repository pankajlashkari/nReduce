Nreduce::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resource :startup do
    member do
      get 'onboard'
      post 'onboard_next'
      get 'dashboard'
    end
  end
  resources :users, :checkins
  get "/users/chat" => "users#chat"

  # for omniauth authentications with other providers
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  # Easy routes for auth/account stuff
  get '/login' => "auth#login"
  get '/logout' => "authentications#destroy"
  delete '/auth' => "authentications#destroy"
  get "/signup" => "registrations#new"

  get "/contact_joe" => "pages#contact_joe"
  

  match "/admin" => redirect("/admin/startups")
  scope :module => "Admin" do
    get "/admin/startups" => "admin_startups#index"
    get "/admin/startups/:id" => "admin_startups#show"
    post "/admin/startups/:id/approve" => "admin_startups#approve_startup"
    post "/admin/startups/:id/deny" => "admin_startups#deny_startup"

    match "/admin/authentications" => "admin_authentications#index"
    post "/admin/authentications/:id/set_partner" => "admin_authentications#set_partner"

    get "/admin/locations" => "admin_locations#index"
    get "/admin/locations/new" => "admin_locations#new"
    post "/admin/locations" => "admin_locations#create"

    get "/admin/locations/:id/edit" => "admin_locations#edit"
    post "/admin/locations/:id/edit" => "admin_locations#update"
    delete "/admin/locations/:id" => "admin_locations#destroy"

    get "/admin/rsvps" => "admin_rsvps#index"

    match "/admin/signups" => "admin_signups#index"
  end

  root :to => 'users#show'
end
