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

ActiveRecord::Schema.define(version: 20170930043833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentication_tokens_on_user_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.bigint "record_book_id", null: false
    t.string "name", null: false
    t.jsonb "points", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_completions", null: false
    t.index ["record_book_id"], name: "index_challenges_on_record_book_id"
  end

  create_table "completions", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "participation_id", null: false
    t.integer "rank", null: false
    t.integer "points", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["challenge_id"], name: "index_completions_on_challenge_id"
    t.index ["participation_id"], name: "index_completions_on_participation_id"
  end

  create_table "moments", force: :cascade do |t|
    t.bigint "record_book_id", null: false
    t.string "trackable_type", null: false
    t.bigint "trackable_id", null: false
    t.integer "moment_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_book_id"], name: "index_moments_on_record_book_id"
    t.index ["trackable_type", "trackable_id"], name: "index_moments_on_trackable_type_and_trackable_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "record_book_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_book_id"], name: "index_participations_on_record_book_id"
    t.index ["team_id"], name: "index_participations_on_team_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "record_books", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "published", default: false, null: false
    t.string "time_zone", default: "UTC", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "rush_start_time"
    t.datetime "rush_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "discord_name", null: false
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "password_updated_at"
    t.integer "membership_type", default: 0, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discord_name"], name: "index_users_on_discord_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
