class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   #[Jerry] add association to user_stock table
   # use the table name "user_stocks" here.(check the db/migrate/)
   #the rule of has_mane. The parameter is modle name with pluralized.(user_stock"s")
   # you can use user = User.first, then user.stocks to link to stocks which this user have
   has_many :user_stocks
   has_many :stocks, through: :user_stocks

   #[Jerry] add for friend system
   has_many :friendships
   has_many :friends, through: :friendships

   #[Jerry] return the full name
   def full_name

     return "#{first_name} #{last_name}".strip if (first_name || last_name)
     "Anonymouse"
   end


   #[Jerry] to restric user can only track 10 stocks.
   #we can use these function on view
   def can_add_stock?(ticker_symbol)
     under_stock_limit? && !stock_already_added?(ticker_symbol)
   end

   def under_stock_limit?
     (user_stocks.count < 10)
   end


   def stock_already_added?(ticker_symbol)
     #we check is the stock in Stock table ?
     stock = Stock.find_by_ticker(ticker_symbol)
     return false unless stock
     # if yes, then check is this stock in user_stock table
     user_stocks.where(stock_id: stock.id).exists?
   end





   #[Jerry] add because add search friend.
    def not_friends_with?(friend_id)

      friendships.where(friend_id: friend_id).count < 1

    end

    def except_current_user(users)
      #looping all users, and to rejecet the user who the userid=selfid
      #and left the others.
      users.reject {|user| user.id == self.id}

    end

    def self.search(param)


      return User.none if param.blank?

      param.strip!
      param.downcase!

      #the three function build below
      #puts (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
      (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq


    end

    def self.first_name_matches(param)

      matches('first_name', param)

    end

    def self.last_name_matches(param)

      matches('last_name', param)

    end

    def self.email_matches(param)

      matches('email', param)

    end

    def self.matches(field_name, param)
      #the %#{param}% will search likely, not ==
      #we hope people key in the search keywork
      #can find out in first name, last name and email
      where("lower(#{field_name}) like ?", "%#{param}%")

    end


end
