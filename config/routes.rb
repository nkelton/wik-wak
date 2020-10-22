Rails.application.routes.draw do
  resources :comment_summaries
  resources :post_summaries
  resources :votes
  resources :comments
  resources :posts

  root 'pages#index'
end
