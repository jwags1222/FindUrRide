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

ActiveRecord::Schema.define(version: 20151006181750) do

  create_table "car_prospects", force: true do |t|
    t.integer  "car_id"
    t.integer  "prospect_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", force: true do |t|
    t.string   "stockid"
    t.string   "make"
    t.string   "model"
    t.string   "year"
    t.string   "link"
    t.string   "link2"
    t.string   "link3"
    t.string   "link4"
    t.integer  "dealer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dealership_id"
  end

  create_table "dealerships", force: true do |t|
    t.string   "streetaddress"
    t.string   "city"
    t.string   "state"
    t.string   "phonenumber"
    t.string   "twilionumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "houses", force: true do |t|
    t.string   "mls_number"
    t.string   "agent"
    t.string   "street_address"
    t.string   "link"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prospects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phonenumber"
    t.string   "test"
  end

  create_table "users", force: true do |t|
    t.string  "fname"
    t.string  "mname"
    t.string  "lname"
    t.string  "password"
    t.string  "email"
    t.string  "cellphone"
    t.integer "dealer_id"
    t.integer "dealership_id"
  end

end
