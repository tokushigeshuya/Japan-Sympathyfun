Rails.application.routes.draw do
  
  namespace :user do
    get 'homes/top'
    root 'user/homes#about'
    
    resources :posts
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
