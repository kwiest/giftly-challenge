# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_18_074622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "businesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "yelp_id"
    t.string "name"
    t.float "rating"
    t.integer "review_count"
    t.string "url"
    t.string "image_url"
    t.string "address_street"
    t.string "address_city"
    t.string "address_state"
    t.string "cross_streets"
    t.float "latitude"
    t.float "longitude"
    t.string "phone_number"
    t.string "price_range"
    t.string "categories", array: true
    t.string "neighborhood"
    t.jsonb "raw_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories"], name: "index_businesses_on_categories", using: :gin
    t.index ["yelp_id"], name: "index_businesses_on_yelp_id", unique: true
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.string "yelp_id"
    t.string "url"
    t.string "text"
    t.float "rating"
    t.jsonb "raw_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["yelp_id"], name: "index_reviews_on_yelp_id", unique: true
  end

end
