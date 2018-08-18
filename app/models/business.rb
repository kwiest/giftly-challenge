class Business < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def self.fetch(business_id)
    find_by(yelp_id: business_id) || create_new_from_api(business_id)
  end

  def address
    @address ||= Address.new(street: address_street, city: address_city, state: address_state)
  end

  private

  def self.create_new_from_api(business_id)
    business = fetch_from_api(business_id)
    transaction do
      business.reviews << fetch_reviews(business_id)
      business.save!
    end
    business
  end

  def self.fetch_from_api(business_id)
    api = YelpApi.new
    json = api.business_details(business_id)
    from_json json
  end

  def self.from_json(json)
    new.tap do |business|
      business.yelp_id = json['id']
      business.name = json['name']
      business.rating = json['rating']
      business.review_count = json['review_count']
      business.url = json['url']
      business.image_url = json['image_url']
      business.address_street = json['location']['address1']
      business.address_city = json['location']['city']
      business.address_state = json['location']['state']
      business.cross_streets = json['location']['cross_streets']
      business.latitude = json['coordinates']['latitude']
      business.longitude = json['coordinates']['longitude']
      business.phone_number = json['display_phone']
      business.categories = json['categories'].map { |c| c['title'] }
      business.neighborhood = json['neighborhood']
      business.price_range = json['price']
      business.raw_response = json
    end
  end

  def self.fetch_reviews(business_id)
    Review.fetch_from_api(business_id)
  end
end
