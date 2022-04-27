Rails.application.routes.draw do

  root 'user/homes#top'
  namespace :user do
    get 'homes/about'
    get 'homes/search'

    resources :posts do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites,only:[:create,:destroy]
    end

    resources :users, only: [:index,:show,:edit,:update] do
      member do
        get 'unsubscribe'
        patch 'withdrawal'
      end
      resource :relationships, only: [:create,:destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    end
  end


  namespace :admin do
    resources :posts, only:[:index,:show,:edit,:update,:destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :users, only:[:index,:show,:edit,:update]
  end
  devise_for :admins, skip: [:registrations,:password],controllers:{
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers:{
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
