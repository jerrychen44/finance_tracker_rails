class Stock < ApplicationRecord

  #[Jerry] add association to user_stock table
  # use the table name "user_stocks" here.(check the db/migrate/)
  #the rule of has_mane. The parameter is modle name with pluralized.(user_stock"s")
  has_many :user_stocks
  has_many :users, through: :user_stocks



  #this is add by stock_quote
  #since we don't have to link with the instance
  #we will define to the class method
  #[Jerry]

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end


  def self.new_from_lookup(ticker_symbol)
    #ref, https://github.com/tyrauber/stock_quote
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name

    #create the new model (follow the db column)
    #check the db/migrate/20160917152810_create_stocks.rb
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price=new_stock.price
    new_stock
  end

  def price
    #if we have closing price, then return as price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price}(closing)" if closing_price

    #if not, we return the opening price as price
    opening_prince=StockQuote::Stock.quote(ticker).open
    return "#{opening_prince}(opening)" if opening_prince
    #if still not have it, return the wording
    'Unavailable'
  end

end
