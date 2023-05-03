Rails.application.routes.draw do
  root 'folders#index'

  get '/folders/learn', to: 'folders#learn'

  resources :folders, except: %i[new edit] do
    resources :cards, only: %i[create update destroy]
  end
end
