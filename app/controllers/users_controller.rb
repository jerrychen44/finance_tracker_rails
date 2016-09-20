class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
    @user = current_user
  end

  #[Jerry] comes from routes
  #[Jerry] add for friend system
  def my_friends
    #we can do that is because we already set the many to mnay
    #association table in model
    @friendships = current_user.friends
    #after get the @friendsips, go to layout to show it up
  end
end
