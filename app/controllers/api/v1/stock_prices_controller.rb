# frozen_string_literal: true

module Api
  module V1
    # this is StockPricesController
    class StockPricesController < ApplicationController
      def price_all
        @stock_prices = LatestStockPrice.price_all
        render json: @stock_prices
      end
    end
  end
end
