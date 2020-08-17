namespace :admin do
  root 'offers#index'
  resources :offers, only: [:index]
end