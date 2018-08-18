class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, id: :uuid do |t|
      t.uuid 'business_id'
      t.string 'yelp_id'
      t.string 'url'
      t.string 'text'
      t.float  'rating'
      t.jsonb  'raw_response'

      t.timestamps
    end

    add_index :reviews, :yelp_id, unique: true
  end
end
