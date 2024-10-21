# frozen_string_literal: true

require 'httparty'

# this is LatestStockPrice
class LatestStockPrice
  include HTTParty
  base_uri 'https://latest-stock-price.p.rapidapi.com'

  def self.price(symbol)
    get('/price', headers: headers, query: { symbol: symbol })
  end

  def self.prices(symbols)
    get('/prices', headers: headers, query: { symbols: symbols })
  end

  def self.price_all
    response = get('/any', headers: headers)
    handle_response(response)
  end

  def self.headers
    {
      'X-RapidAPI-Key' => 'ffeae5a0e1mshe2e21651f88effep103426jsnccfc923dcfbd',
      'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com',
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  def self.handle_response(response)
    raise "Error fetching data: #{response.code} - #{response.message}" unless response.success?

    response.parsed_response
  end
end
