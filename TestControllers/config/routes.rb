Rails.application.routes.draw do
  post 'relationships/create'
  delete 'relationships/destroy'

  resources :users, except: %i[new edit] do
    get :following, :followers, on: :member
    post :upload, on: :member
  end

  get '/signup', to: 'registration#new'
  post '/signup', to: 'registration#sign_up'

  get '/login', to: 'authentication#new'
  post '/login', to: 'authentication#login'
  delete '/logout', to: 'authentication#logout', as: 'logout'

  root 'users#index'

  resources :folders, except: %i[new edit] do
    get :learn, on: :collection
    resources :cards, only: %i[create update destroy]
  end
end
