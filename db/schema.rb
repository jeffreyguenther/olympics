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

ActiveRecord::Schema.define(version: 20180308010653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attempts", force: :cascade do |t|
    t.integer "weight"
    t.integer "athlete_id"
    t.integer "movement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weighted_max_effort_id"
    t.boolean "success", default: false
    t.integer "attempt"
    t.index ["athlete_id"], name: "index_attempts_on_athlete_id"
    t.index ["movement_id"], name: "index_attempts_on_movement_id"
    t.index ["weight"], name: "index_attempts_on_weight"
    t.index ["weighted_max_effort_id"], name: "index_attempts_on_weighted_max_effort_id"
  end

  create_table "movements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "weighted_max_efforts", force: :cascade do |t|
    t.integer "lifts"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
