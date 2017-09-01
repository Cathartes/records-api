Rails.application.routes.draw do
  apipie

  namespace :v1, defaults: { format: :json } do
    resources :challenges

    resources :completions, except: :show

    resources :participations

    resource :passwords, only: %i[create update]

    resources :record_books

    resource :sessions, except: %i[update]

    resources :teams

    resources :users, only: %i[create update]
  end

  root 'application#index'
end
