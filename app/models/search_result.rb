class SearchResult
  attr_accessor :business_id, :name, :rating, :image_url,
    :address_street, :address_city, :address_state, :distance

  def initialize(params)
    @business_id = params['id']
    @name = params['name']
    @rating = params['rating']
    @image_url = params['image_url']
    @address_street = params['location']['address1']
    @address_city = params['location']['city']
    @address_state = params['location']['state']
    @distance = params['distance']
  end

  def formatted_address
    "#{address_street}, #{address_city}, #{address_state}"
  end

  # Yelp returns distance in meters
  def miles_away
    miles = distance / 1609.344
    "#{miles.round(1)} miles away"
  end

  def rating_image_path
    if rating % 1 > 0
      "yelp_stars/small_#{rating.to_i}_half.png"
    else
      "yelp_stars/small_#{rating.to_i}.png"
    end
  end
end
