RailsComposerApp2::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :site_items

  resources :site_cates


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

  get "home/modal_window"
  get "home/index_static"
  get "home/like_view"
  match "us" => "home#us"
  match "chrome" => "home#chrome"
end