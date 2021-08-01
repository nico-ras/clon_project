Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    get 'retweet'
    post 'retweet'
    resources :likes
  end  
  resources :friends
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'tweets#index'
  get 'tweets/hashtag/:name', to:'tweets#hashtags'
  
  get 'api/news', to: 'api#news'
  resources :api 
  get 'api/:fecha1/:fecha2', to: 'api#between'
  

  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
