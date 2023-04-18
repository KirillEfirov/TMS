Rails.application.routes.draw do
  root 'folders#index'

  resources :folders, except: %i[new edit] do
    resources :cards, only: %i[create update destroy]
  end
end
