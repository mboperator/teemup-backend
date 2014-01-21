# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140121051111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "api_keys", force: true do |t|
    t.string  "access_token"
    t.integer "user_id"
  end

  add_index "api_keys", ["access_token"], :name => "index_api_keys_on_access_token"
  add_index "api_keys", ["user_id"], :name => "index_api_keys_on_user_id"

  create_table "group_memberships", force: true do |t|
    t.integer  "group_id",                     null: false
    t.integer  "user_id",                      null: false
    t.boolean  "is_admin",     default: false
    t.boolean  "is_confirmed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.text     "name",          null: false
    t.text     "description"
    t.integer  "created_by_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
