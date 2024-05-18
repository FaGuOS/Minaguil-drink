Rails.application.routes.draw do
  # HomesController
  root to: 'homes#top'
  
  get '/home', to: 'homes#home'
  get '/about', to: 'homes#about'
  
  # PagesController
  resources :posts do
    member do
      put :hide
    end
    collection do
      get :rankings
    end
    resources :comments, only: [:index, :new, :create, :destroy]
  end

  # UsersController
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # カスタムアクションのみを設定
  resources :users, only: [] do
    member do
      get :exit
      delete :good_bye
    end
  end

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
