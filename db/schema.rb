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

ActiveRecord::Schema.define(version: 2020_02_03_130607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.string "state"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.boolean "approved"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "approved_by"
    t.index ["employee_id"], name: "index_documents_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "names"
    t.string "email"
    t.string "idcard"
    t.string "password"
    t.boolean "admin"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "department"
    t.boolean "head"
    t.integer "leave_balance"
  end

  create_table "leaves", force: :cascade do |t|
    t.text "reason"
    t.datetime "start"
    t.datetime "end"
    t.boolean "approved"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "approved_by"
    t.string "category"
    t.boolean "recommended"
    t.datetime "date_recommended"
    t.datetime "date_approved"
    t.bigint "recommended_by"
    t.datetime "expected"
    t.index ["employee_id"], name: "index_leaves_on_employee_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.inet "ip"
    t.string "lat"
    t.string "long"
    t.string "state"
    t.string "loc_type"
    t.bigint "loc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loc_type", "loc_id"], name: "index_locations_on_loc_type_and_loc_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "state"
    t.text "cookie"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "loc_updated_at"
    t.index ["employee_id"], name: "index_sessions_on_employee_id"
  end

  create_table "useragents", force: :cascade do |t|
    t.string "full"
    t.string "browser"
    t.string "os"
    t.string "ua_type"
    t.bigint "ua_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ua_type", "ua_id"], name: "index_useragents_on_ua_type_and_ua_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "employees"
  add_foreign_key "documents", "employees"
  add_foreign_key "leaves", "employees"
  add_foreign_key "sessions", "employees"
end
