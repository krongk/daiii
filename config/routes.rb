RailsComposerApp2::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :site_items do
    collection do
      get :tag
    end
  end

  resources :site_cates

  devise_for :users
  resources :users

  

  get "home/modal_window"
  get "home/like_view"
  get "dashboard/index"
  match "us" => "home#us"
  match "add_quote" => "home#add_quote"
  match "quote_added" => "home#quote_added"
  match "chrome" => "home#chrome"
  match "public_share" => "home#public_share"
  match "tags" => "site_items#tags"

  root :to => "home#index"
  authenticated :user do
    root :to => 'dashboard#index'
  end
end