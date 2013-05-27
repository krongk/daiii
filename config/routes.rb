RailsComposerApp2::Application.routes.draw do
  get "dashboard/index"

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :site_items

  resources :site_cates


  authenticated :user do
    root :to => 'dashboard#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

  get "home/modal_window"
  get "home/like_view"

  match "us" => "home#us"
  match "add_quote" => "home#add_quote"
  match "quote_added" => "home#quote_added"
  match "chrome" => "home#chrome"
end