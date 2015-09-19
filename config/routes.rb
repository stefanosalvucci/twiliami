Rails.application.routes.draw do

  root 'spaces#index'

  resources :spaces do
    member do
      post :forward
    end
  end

  resources :requests do
    member do
      post :forward
    end
  end

  get 'client', to: 'twilio#client'
  get 'owner', to: 'twilio#owner'
end