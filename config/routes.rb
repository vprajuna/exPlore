Rails.application.routes.draw do
  resources :places
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "places#show"
  
  # config/routes.rb
  get '/places/:id/love', to: 'places#love', as: 'love_place'
  get '/places/:id/hate', to: 'places#hate', as: 'hate_place'


end
