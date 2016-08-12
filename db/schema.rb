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

ActiveRecord::Schema.define(version: 20160811235721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "num_sessions",   default: 1
    t.integer  "session_length", default: 30
    t.integer  "skill_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "week_number"
    t.index ["skill_id"], name: "index_goals_on_skill_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "duration",   default: 30
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["skill_id"], name: "index_sessions_on_skill_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "nickname"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_skills_on_user_id", using: :btree
  end

  create_table "user_followers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_user_followers_on_user_id", using: :btree
  end

  create_table "userfollowers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "gh_uid"
    t.string   "gh_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "quiz_id"
    t.string   "quiz_token"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "image"
  end

  add_foreign_key "sessions", "skills"
  add_foreign_key "user_followers", "users"
end
