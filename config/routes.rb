Rails.application.routes.draw do
  # HomesController
  root to: 'homes#top'
  
  get '/home', to: 'homes#home'
  get '/about', to: 'homes#about'
  
  # PostsController
  resources :posts do
    member do
      put :hide
      post :nonsence
      post :increment_yes
    end
    collection do
      put 'hide_selected', to: 'posts#hide_selected', as: :hide_selected
      get :rankings
      get :weekly_ranking
    end
    
    resources :comments, only: [:index, :new, :create, :show, :destroy]
    post 'create_comment', to: 'posts#create_comment', as: 'create_comment'
    resources :yeses, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end

  # UsersController
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'devise/passwords'
  }
  
  get 'profile/:id', to: 'users#show', as: 'profile'

  # カスタムアクションの設定
  resources :users do
    member do
      get :exit
      delete :good_bye
    end
  end
  
  resources :bookmarks, only: [:index, :create, :destroy]
  
  get 'search', to: 'searches#index', as: 'search'

  # AdminSessionsController
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  # Admin namespace
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :reports, only: [:index, :show, :destroy]
    resources :users, except: [:new, :create, :destroy]
    resources :regions, only: [] do
      member do
        get :edit
        put :update
      end
    end
  end
end
