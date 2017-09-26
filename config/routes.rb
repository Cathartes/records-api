Rails.application.routes.draw do
  apipie

  namespace :v1, defaults: { format: :json } do
    resources :challenges

    resources :completions, except: :show

    resources :participations

    resource :passwords, only: %i[create update]

    resources :record_books

    resource :sessions, except: :update

    resources :teams

    resources :users, except: :destroy
  end

  root 'application#index'
end
