# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_13_131347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.time "starts_at"
    t.time "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "duration"
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_events_on_club_id"
  end

  create_table "gametables", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "description"
    t.integer "active"
    t.integer "display_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_gametables_on_club_id"
  end

  create_table "rents", force: :cascade do |t|
    t.integer "balls"
    t.integer "rackets"
    t.integer "robot"
    t.bigint "trainer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainer_id"], name: "index_rents_on_trainer_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "gametable_id", null: false
    t.datetime "time"
    t.integer "price"
    t.integer "state", default: 0
    t.string "bookable_type"
    t.bigint "bookable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookable_type", "bookable_id"], name: "index_slots_on_bookable"
    t.index ["gametable_id"], name: "index_slots_on_gametable_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "rating"
    t.integer "price"
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_tournaments_on_club_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.bigint "club_id", null: false
    t.string "trainer"
    t.integer "price"
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_trainings_on_club_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "club_id", null: false
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "events", "clubs"
  add_foreign_key "gametables", "clubs"
  add_foreign_key "rents", "users", column: "trainer_id"
  add_foreign_key "slots", "gametables"
  add_foreign_key "tournaments", "clubs"
  add_foreign_key "trainings", "clubs"
  add_foreign_key "users", "clubs"
end
