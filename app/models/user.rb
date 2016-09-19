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
end
