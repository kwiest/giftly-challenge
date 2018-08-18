class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string  'yelp_id'
      t.string  'name'
      t.float   'rating'
      t.integer 'review_count'
      t.string  'url'
      t.string  'image_url'
      t.string  'address_street'
      t.string  'address_city'
      t.string  'address_state'
      t.string  'cross_streets'
      t.float   'latitude'
      t.float   'longitude'
      t.string  'phone_number'
      t.string  'price_range'
      t.string  'categories', array: true
      t.string  'neighborhood'
      t.jsonb   'raw_response'

      t.timestamps
    end

    add_index :businesses, :yelp_id, unique: true
    add_index :businesses, :categories, using: 'gin'
  end
end
