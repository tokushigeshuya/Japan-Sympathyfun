Rails.application.routes.draw do

  namespace :user do
    get 'homes/top'
    root 'user/homes#about'

    resources :posts do
      resources :post_comments, only: [:create]
    end

    resources :users, only: [:index,:show,:edit,:update] do
      member do
        get 'unsubscribe'
        patch 'withdrawal'
      end
      resource :relationships, only: [:create,:destroy] do
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
    end
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
