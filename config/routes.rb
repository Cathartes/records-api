Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  apipie

  post '/graphql', to: 'graphql#execute'

  namespace :v1, defaults: { format: :json } do
    resources :challenges

    resources :completions, except: :show

    resources :moments, only: :index

    resources :participations

    resource :passwords, only: %i[create update]

    resources :record_books

    resource :sessions, except: :update

    resources :teams

    resources :users, except: :destroy
  end

  root 'application#index'
end
