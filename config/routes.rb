Rails.application.routes.draw do
  # HomesController
  root to: 'homes#top'

  get '/home', to: 'homes#home'
  get '/about', to: 'homes#about'

  # PostsController
  resources :posts do
    resource :yes, only: [:create, :destroy, :index]
    member do
      put :hide
      post 'yes', to: 'posts#increment_yes'
      post 'nonsence', to: 'posts#nonsence'
      post 'add_tag'
      delete 'remove_tag'
    end
    collection do
      put 'hide_selected', to: 'posts#hide_selected', as: :hide_selected
      get :rankings
      get :weekly_ranking
    end

    resources :comments, only: [:index, :new, :create, :show, :destroy]
    post 'create_comment', to: 'posts#create_comment', as: 'create_comment'
    resources :bookmarks, only: [:create, :destroy]
  end

  # UsersController
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'devise/passwords'
  }, path: '', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up',
    password: 'password'
  }

  get 'profile/:id', to: 'users#show', as: 'profile'

  # ユーザーまわり
  resources :users do
    member do
      get :exit
      delete :good_bye
      get :posts
    end
  end

  resources :bookmarks, only: [:index, :create, :destroy]

  resources :tags, only: [:index, :show]

  get 'search', to: 'searches#index', as: 'search'

  get 'users/:id/activity', to: 'users#activity', as: 'user_activity'

  # AdminSessionsController
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'devise/passwords'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }

  # Admin namespace
  namespace :admins do
    get 'home', to: 'dashboard#index', as: :home
    resources :dashboard, only: [:index] do
      member do
        delete :destroy_user
        delete :destroy_post
      end
    end
    resources :posts, only: [:index, :show, :destroy]
    resources :reports, only: [:index, :show, :destroy]
    resources :users, except: [:new, :create, :destroy]
    resources :comments, only: [:index, :destroy] do
      member do
        get :edit
        put :update
      end
    end
  end
end
