Rails.application.routes.draw do
  root 'images#top'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post    '/serach',     to: 'images#serach'
  get     '/sorting',    to: 'images#sorting'

  post    '/record',     to: 'images#record'
  post    '/newrecord', to: 'images#newrecord'
  post    '/addrecordtest',  to: 'images#addrecordtest'

  post    '/test',       to: 'images#test'

  post    '/tagset/:id',     to: 'users#tagset'

  get     '/images/index',    to: 'images#index'

  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
