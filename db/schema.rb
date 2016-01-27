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

ActiveRecord::Schema.define(version: 20160127231816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facebook_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "group_id",   limit: 255
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "facebook_groups", ["user_id"], name: "index_facebook_groups_on_user_id", using: :btree

  create_table "facebook_pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "page_id",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "facebook_pages", ["user_id"], name: "index_facebook_pages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                                           null: false
    t.string   "encrypted_password",    limit: 128,               null: false
    t.string   "confirmation_token",    limit: 128
    t.string   "remember_token",        limit: 128,               null: false
    t.string   "facebook_id",           limit: 255
    t.string   "facebook_access_token", limit: 255
    t.string   "last_facebook_account", limit: 255, default: "0"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
