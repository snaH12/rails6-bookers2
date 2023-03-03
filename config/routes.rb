Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  
  devise_for :users
  resources :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
  end
  
  
end
