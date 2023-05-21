Rails.application.routes.draw do
  resources :users, except: %i[new edit] do
    get :following, :followers, on: :member
  end

  get '/signup', to: 'users#new'
  get '/login', to: 'authentication#new'
  post '/login', to: 'authentication#create'
  delete '/logout', to: 'authentication#destroy', as: 'logout'

  root 'users#index'

  resources :folders, except: %i[new edit] do
    get :learn, on: :collection
    resources :cards, only: %i[create update destroy]
  end
end
