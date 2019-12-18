Rails.application.routes.draw do
  root 'homes#index'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resource :user do
    get "retire"
  end

  resources :events, except: :index do
    resources :tickets, only: [:new, :create, :destroy]
  end
  match '*path' => 'application#error404', via: :all
end
