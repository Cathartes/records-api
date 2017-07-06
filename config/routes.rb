Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    resources :users, only: %i[create update]

    post   '/login'  => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
  end

  root 'application#index'
end
