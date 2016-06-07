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

ActiveRecord::Schema.define(version: 20160524085425) do

  create_table "ads", force: :cascade do |t|
    t.integer  "district_id",     limit: 4
    t.integer  "type_parking_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "period_id",       limit: 4
    t.text     "content",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ads", ["district_id"], name: "index_ads_on_district_id", using: :btree
  add_index "ads", ["period_id"], name: "index_ads_on_period_id", using: :btree
  add_index "ads", ["type_parking_id"], name: "index_ads_on_type_parking_id", using: :btree
  add_index "ads", ["user_id"], name: "index_ads_on_user_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "city_towns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "area_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "city_towns", ["area_id"], name: "index_city_towns_on_area_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "city_town_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "districts", ["city_town_id"], name: "index_districts_on_city_town_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "ad_id",      limit: 4
    t.string   "name",       limit: 255
    t.string   "path",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "images", ["ad_id"], name: "index_images_on_ad_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "properts", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "type_parkings", force: :cascade do |t|
    t.string   "Name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fio",                    limit: 255
    t.string   "login",                  limit: 255
    t.string   "phone",                  limit: 255
    t.integer  "role_id",                limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
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

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "ads", "districts"
  add_foreign_key "ads", "periods"
  add_foreign_key "ads", "type_parkings"
  add_foreign_key "ads", "users"
  add_foreign_key "city_towns", "areas"
  add_foreign_key "districts", "city_towns"
  add_foreign_key "images", "ads"
  add_foreign_key "users", "roles"
end
