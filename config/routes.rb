Rails.application.routes.draw do
  resources :votes
  resources :comments
  resources :posts

  root 'pages#index'
end
