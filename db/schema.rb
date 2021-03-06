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

ActiveRecord::Schema.define(version: 11) do

  create_table "cohorts", force: :cascade do |t|
    t.string "name"
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
  end

  create_table "lunches", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "restaurant_id"
    t.datetime "datetime"
  end

  create_table "people", force: :cascade do |t|
    t.string  "name"
    t.integer "cohort_id"
  end

  create_table "restaurantcategories", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "cuisine_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string  "name"
    t.float   "rating"
    t.string  "price"
    t.string  "address"
    t.integer "all_time_popularity", default: 0
    t.integer "today_popularity",    default: 0
    t.string  "url"
  end

end
