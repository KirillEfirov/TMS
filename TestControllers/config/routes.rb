Rails.application.routes.draw do
  resources :users, except: %i[new edit]

  get '/signup', to: 'users#new'
  get '/login', to: 'authentication#new'
  post '/login', to: 'authentication#create'
  delete '/logout', to: 'authentication#destroy', as: 'logout'

  root 'users#index'

  get '/folders/learn', to: 'folders#learn'

  resources :folders, except: %i[new edit] do
    resources :cards, only: %i[create update destroy]
  end
end
