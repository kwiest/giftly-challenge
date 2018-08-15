require 'net/http'

class Search
  class Error < StandardError; end;

  YELP_API_ENDPOINT = 'https://api.yelp.com/v3/businesses/search'.freeze

  attr_accessor :q, :latitude, :longitude, :area_name, :results

  def initialize(params)
    @q = params[:q]
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @area_name = params[:area_name]
    @yelp_api_key = ENV['YELP_API_KEY']
  end

  def perform
    uri = URI(YELP_API_ENDPOINT)
    uri.query = URI.encode_www_form(query_params)

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


  private

  attr_reader :yelp_api_key, :response

  def handle_response
    json = JSON.parse(response.body)

    if response.code == '200'
      @results = json['businesses'].map { |business| SearchResult.new business }
    else
      raise Error.new json['error']['description']
    end
  end

  def query_params
    {
      term: @q,
      latitude: @latitude,
      longitude: @longitude,
      limit: 5
    }
  end
end
