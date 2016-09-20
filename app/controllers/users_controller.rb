class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
    @user = current_user
  end

  #[Jerry] comes from routes
  #[Jerry] add for friend system
  def my_friends
  end
end
