Rails.application.routes.draw do
  devise_for :users
  get 'posts/index'
  root to: "posts#index"
  resources :users, only: [:edit, :update, :show]
  resources :posts do
    get 'page/:page', :action => :index, :on => :collection
    collection do
      get 'search'
    end
  end
end
