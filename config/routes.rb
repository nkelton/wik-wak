Rails.application.routes.draw do
  resources :comments
  resources :posts

  root 'pages#index'
end
