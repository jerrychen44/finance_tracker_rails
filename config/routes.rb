Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #[Jerry] set root to go welcome/index page
  root 'welcome#index'
  #[Jerry] implement the portfolio page, will need to implement the users controller by myself
  get 'my_protfolio', to: "users#my_protfolio"

end
