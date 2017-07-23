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

ActiveRecord::Schema.define(version: 20170723094449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_activity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["room_activity_id"], name: "index_activities_on_room_activity_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "room_actions", force: :cascade do |t|
    t.integer "room_id"
    t.integer "action_id"
    t.index ["action_id"], name: "index_room_actions_on_action_id", using: :btree
    t.index ["room_id"], name: "index_room_actions_on_room_id", using: :btree
  end

  create_table "room_activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "room_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "enabled",    default: true
    t.index ["room_id"], name: "index_room_activities_on_room_id", using: :btree
  end

  create_table "room_requests", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_requests_on_room_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_action_id"
    t.integer  "value",          default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["room_action_id"], name: "index_user_actions_on_room_action_id", using: :btree
    t.index ["user_id"], name: "index_user_actions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "room_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "photo_url"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["room_id"], name: "index_users_on_room_id", using: :btree
  end

  add_foreign_key "activities", "room_activities"
  add_foreign_key "activities", "users"
  add_foreign_key "room_actions", "actions"
  add_foreign_key "room_actions", "rooms"
  add_foreign_key "room_activities", "rooms"
  add_foreign_key "room_requests", "rooms"
  add_foreign_key "user_actions", "room_actions"
  add_foreign_key "user_actions", "users"
  add_foreign_key "users", "rooms"
end
