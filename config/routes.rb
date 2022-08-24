Rails.application.routes.draw do
  get "reservations" => "reservations#index"
  post "reservations/new" => "reservations#new"
  get "reservations/new" => "reservations#new"
  post "reservations/:id" => "reservations#show"
  get "reservations/:id" => "reservations#show"

  post "rooms/create" => "rooms#create"
  get "rooms/create" => "rooms#create"
  get "rooms/posts" => "rooms#posts"
  resources :rooms do
    collection do
      get 'search'
    end
  end
  post "rooms/:id" => "rooms#show"

  get "users/account" => "other_than_devise#account"
  get "users/profile" => "other_than_devise#edit"
  post "users/profile/update" => "other_than_devise#update"
  get "users/profile/update" => "other_than_devise#edit"

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get "/" => "home#top"
end
