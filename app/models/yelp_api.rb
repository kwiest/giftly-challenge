require 'net/http'

class YelpApi
  class Error < StandardError; end;

  YELP_API_BASE_URL = 'https://api.yelp.com/v3'.freeze

  attr_accessor :result

  def initialize
    @yelp_api_key = ENV['YELP_API_KEY']
  end

  def search(query_params)
    uri = URI("#{YELP_API_BASE_URL}/businesses/search")
    uri.query = URI.encode_www_form(query_params)
    perform uri
  end

  def business_details(business_id)
    uri = URI("#{YELP_API_BASE_URL}/businesses/#{business_id}")
    perform uri
  end

  def business_reviews(business_id)
    uri = URI("#{YELP_API_BASE_URL}/businesses/#{business_id}/reviews")
    perform uri
  end


  private

  attr_reader :yelp_api_key, :response

  def perform(uri)
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{yelp_api_key}"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    begin
      @response = http.request(request)
    rescue Exception => e
      Rails.logger.error("Error searching Yelp API, #{e.class} - #{e.message}")
    end

    handle_response
  end

  def handle_response
    if response.code == '200'
      @result = JSON.parse(response.body)
    else
      raise Error.new json['error']['description']
    end
  end
end
