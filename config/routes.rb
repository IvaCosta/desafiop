Rails.application.routes.draw do 

  

  devise_for :users
  root 'home#index'
  
  resources :lists, only: [:index, :show, :create, :update, :destroy] do
    resources :subscribers, only: [:index, :show, :create, :update, :destroy]
  end
  resources :campaigns
  resources :campaign_lists do
     member do
      post 'new'
	end
  end
end
