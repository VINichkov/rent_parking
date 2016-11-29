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

ActiveRecord::Schema.define(version: 20160911094715) do

  create_table "bookings", force: :cascade do |t|
    t.datetime "datetimebegin"
    t.datetime "datetimeend"
    t.integer  "user_id",       limit: 4
    t.integer  "parking_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "bookings", ["parking_id"], name: "index_bookings_on_parking_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "parkings", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "adress",       limit: 255
    t.float    "latitude",     limit: 24
    t.float    "langitude",    limit: 24
    t.boolean  "accessible"
    t.boolean  "open24"
    t.boolean  "covered"
    t.boolean  "sitestaff"
    t.boolean  "overnight"
    t.boolean  "valet"
    t.boolean  "restrictions"
    t.boolean  "descriptions"
    t.float    "price",        limit: 24
    t.boolean  "typerent"
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "parkings", ["user_id"], name: "index_parkings_on_user_id", using: :btree

  create_table "patchphotos", force: :cascade do |t|
    t.integer  "parking_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_uid",  limit: 255
  end

  create_table "properts", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "code",         limit: 255
    t.string   "name",         limit: 255
    t.text     "descriptions", limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "surname",                limit: 255
    t.string   "login",                  limit: 255
    t.string   "email",                  limit: 255
    t.string   "namberphone",            limit: 255
    t.integer  "role_id",                limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "bookings", "parkings"
  add_foreign_key "bookings", "users"
  add_foreign_key "parkings", "users"
  add_foreign_key "users", "roles"
end
