RailsComposerApp2::Application.routes.draw do
  resources :site_items


  resources :site_cates


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end