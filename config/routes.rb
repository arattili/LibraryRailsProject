Rails.application.routes.draw do
  resources :bookings
  resources :rooms
  resources :users
  get '/login' => 'users#login', as: 'login'
  get '/users/error' => 'users#error', as: 'error'
  get '/logout' => 'users#logout', as: 'logout'
  get '/myrooms' => 'users#myRooms', as: 'myRooms'
  post '/users/loginTry' => 'users#loginTry', as: 'loginTry'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
