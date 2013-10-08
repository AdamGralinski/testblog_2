Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    
    resources :comments do
      member do
        post :voteup
        post :votedown
        post :not_abusive
      end
    end
    
    member do
      post :mark_archived
    end
  end
end
