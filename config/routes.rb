Rails.application.routes.draw do
  resources :user_stocks
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #[Jerry] set root to go welcome/index page
  root 'welcome#index'
  #[Jerry] implement the portfolio page, will need to implement the users controller by myself
  get 'my_portfolio', to: "users#my_portfolio"

  #[Jerry] add stock UI, we add serach_stocks here first, build the serach_stocks in controlers/ and add the search method inside it later.
  get 'search_stocks', to: "stocks#search"

end
