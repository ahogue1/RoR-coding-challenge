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

ActiveRecord::Schema.define(version: 20190608183151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banner_people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "house_id"
    t.string "name"
    t.index ["house_id"], name: "index_banner_people_on_house_id"
  end

  create_table "handouts", force: :cascade do |t|
    t.date "date"
    t.integer "value"
    t.bigint "banner_person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_person_id"], name: "index_handouts_on_banner_person_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loyalty_points", force: :cascade do |t|
    t.date "date"
    t.float "value"
    t.bigint "banner_person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_person_id"], name: "index_loyalty_points_on_banner_person_id"
  end

  add_foreign_key "banner_people", "houses"
  add_foreign_key "handouts", "banner_people"
  add_foreign_key "loyalty_points", "banner_people"
end
