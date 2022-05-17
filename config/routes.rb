Rails.application.routes.draw do
  resources :posts do
    get 'page/:page', action: :index, on: :collection
  end
  get 'posts/:id/comment', to: 'posts#comment'
  post 'posts/:id/upvote', to: 'posts#upvote'
  post 'posts/:id/unvote', to: 'posts#unvote'

  root to: 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
