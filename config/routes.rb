Rails.application.routes.draw do
  root 'images#top'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #作成中
  post    '/serach',     to: 'images#serach'
  get     '/sorting',    to: 'images#sorting'

  post    '/record', to: 'images#record'

  get     '/test',        to: 'images#ssend'

  #作成予定
  post    '/tagset/:id',     to: 'users#tagset'

  get     '/images/success', to: 'images#success'

  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
