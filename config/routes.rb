Rails.application.routes.draw do
  #resources :user_stocks
  #devise_for :users

  #[Jerry] we force if you want to find the controllers for registrations, find the user/registration first
  devise_for :users, :controllers => { :registrations => "user/registrations" }



  #[Jerry] just be save, we move the resources :user_stocks to under the devise_for :users
  #because this user_stocks table need the user model.
  resources :user_stocks, except: [:show, :edit,:update] # we don't need these feature,we only need the create, destory action

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #[Jerry] set root to go welcome/index page
  root 'welcome#index'
  #[Jerry] implement the portfolio page, will need to implement the users controller by myself
  get 'my_portfolio', to: "users#my_portfolio"

  #[Jerry] add stock UI, we add serach_stocks here first, build the serach_stocks in controlers/ and add the search method inside it later.
  get 'search_stocks', to: "stocks#search"


  #[Jerry] add for friend system
  get 'my_friends', to: 'users#my_friends'
  resources :users, only: [:show]
  resources :friendships

  #[Jerry] for search friend, add search adn add_friend in user controller later
  get 'search_friends', to: 'users#search'
  #we want to really add the association with friend, so use post.
  post 'add_friend', to: 'users#add_friend'
end
