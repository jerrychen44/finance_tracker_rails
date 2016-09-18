class StocksController < ApplicationController
  def search
    #[Jerry] if stock params passed in from parames[]
    if params[:stock]
      #we find_by_ticker for @stock
      @stock = Stock.find_by_ticker(params[:stock])
      #if stock still nil, then we give the other object
      #which return by new_from_lookup we build before.
      @stock ||=Stock.new_from_lookup(params[:stock])
    end

    if @stock
      #[Jerry] for testing, you can using http://localhost:3000/search_stocks?stock=GOOG
      #and will get the {"id":null,"ticker":"GOOG","name":"Alphabet Inc.","last_price":"769.75","created_at":null,"updated_at":null}
      #render json: @stock



      #[Jerry] we will build the partial _lookup later
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end






end
