RailsComposerApp2::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :site_items do
    collection do
      get :tag
    end
  end

  devise_for :users
  resources :users

  get "home/modal_window"
  get "home/index"
  get "home/index_static"
  match "us" => "home#us"
  match "s" => "home#setting"
  match "add_quote" => "home#add_quote"
  match "quote_added" => "home#quote_added"
  match "h" => "home#help"
  match "chrome" => "home#chrome"
  match "home" => "home#index"
  match "friend_link" => "home#friend_link"
  match "public_share" => "home#public_share"
  match "tags" => "site_items#tags"

  root :to => "home#index_static"
  authenticated :user do
    root :to => 'home#index'
  end
end