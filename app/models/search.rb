class Search
  attr_accessor :q, :latitude, :longitude, :area_name, :results

  def initialize(params)
    @q = params[:q]
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @area_name = params[:area_name]
  end

  def perform
    api = YelpApi.new
    api.search query_params
    @results = api.result['businesses'].map { |business| SearchResult.new business }
  end


  private

  def query_params
    {
      term: @q,
      latitude: @latitude,
      longitude: @longitude,
      limit: 5
    }
  end
end
