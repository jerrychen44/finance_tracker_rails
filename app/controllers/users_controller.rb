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

  #add because the friedn search, you can see in the routes
  def search
    # we need to implement the class method search in user.rb model later.
    #puts params[:search_param]
    @users = User.search(params[:search_param]) # from views/friends/_lookup.html.erb text_field_tag.....passed in

    if @users
      #we will build except_current_user in user.rb model later. we don't want to show ourself as a searching result.
      #puts @users
      @users = current_user.except_current_user(@users)
      puts @users.size
      render partial: "friends/lookup"
    else
      render status: :not_found, nothing: true
    end
  end


  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)

    if current_user.save
      redirect_to my_friends_path, notice: "Friend was successfully added"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend"
    end


  end
end
