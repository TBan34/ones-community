Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  # ユーザー用ルーティング
  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    get "/search" => "searches#search"
    resources :users, only: [:show, :edit, :update] do
      get "unsubscribe" => "users#unsubscribe"
      patch "withdrawal" => "users#withdrawal"
      resources :favorites, only: [:index]
    end
    resources :notifications, only: [:index]
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :rooms, only: [:create, :index, :show]
  end
  
  # 管理者用ルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :destroy]
    resources :tags, only: [:create, :index, :edit, :update]
    resources :rooms, only: [:index, :show, :destroy]
  end
  
  # ゲストユーザー用ルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    post "users/guest_sign_out", to: "users/sessions#guest_sign_out"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
