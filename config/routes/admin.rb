namespace :admin do
  root 'offers#index'
  resources :offers do
    member do
      post :switch_state
    end
  end
end