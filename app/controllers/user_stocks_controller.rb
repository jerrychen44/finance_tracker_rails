class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  # GET /user_stocks
  # GET /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1
  # GET /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks
  # POST /user_stocks.json
  def create
    #[Jerry] we pass in many parameter from _lookup.html.erb line:34
    #we can use these parameter by params[] hash.
    if params[:stock_id].present?
      #if there is a stock passed from view with the valid stock_id


      #copy from below, and change the parameter to fit our table
      #stock_id, user_id: (you give it the user, it will automaticly get the user_id)
      @user_stock = UserStock.new(stock_id: params[:stock_id], user: current_user)
    else # this stock id not in oure database
      #if the stock id is nil or somting not valid
      #find from db. (find_by_ticker comes from models/stock.rb)
      stock = Stock.find_by_ticker(params[:stock_ticker])
      if stock #if find db successfully.we set it to the user_stock table
        @user_stock = UserStock.new(user: current_user, stock: stock)
      else# find ticker in db failed
        #we find the stock from yahoo
        stock = Stock.new_from_lookup(params[:stock_ticker])
        if stock.save # if the stock is valid and save successfully, we created_at the relatetion on user_stock table
          @user_stock = UserStock.new(user: current_user, stock: stock)
        else
          @user_stock = nil
          flash[:error] = "Stock is not available"
        end
      end
    end


    #@user_stock = UserStock.new(user_stock_params)

    respond_to do |format|
      if @user_stock.save
        #[Jerry] if save successfully, go to my_portfolio page
        format.html { redirect_to my_portfolio_path, notice: "Stock #{@user_stock.stock.ticker}
                                                      successfully added" }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stocks/1
  # PATCH/PUT /user_stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to @user_stock, notice: 'User stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1
  # DELETE /user_stocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to user_stocks_url, notice: 'User stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = UserStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end
