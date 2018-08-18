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

  def address
    @address ||= Address.new(street: address_street, city: address_city, state: address_state)
  end
end
