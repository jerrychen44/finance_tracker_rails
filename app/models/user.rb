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



end
