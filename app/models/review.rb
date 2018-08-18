class Review < ApplicationRecord
  belongs_to :business

  def self.fetch_from_api(business_id)
    api = YelpApi.new
    json = api.business_reviews(business_id)
    json['reviews'].map { |review_json| from_json(review_json) }
  end

  private

  def self.from_json(json)
    new.tap do |review|
      review.yelp_id = json['id']
      review.url = json['url']
      review.text = json['text']
      review.rating = json['rating']
      review.raw_response = json
    end
  end
end
