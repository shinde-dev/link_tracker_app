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

ActiveRecord::Schema[7.1].define(version: 2024_06_09_060122) do
  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "store_urls", force: :cascade do |t|
    t.string "url", null: false
    t.string "tracking_code"
    t.integer "client_id"
    t.boolean "valid_url", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_store_urls_on_client_id"
    t.index ["tracking_code"], name: "index_store_urls_on_tracking_code", unique: true
  end

  create_table "url_trackings", force: :cascade do |t|
    t.json "metadata", default: {}
    t.integer "store_url_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_url_id"], name: "index_url_trackings_on_store_url_id"
  end

  add_foreign_key "store_urls", "clients"
  add_foreign_key "url_trackings", "store_urls"
end
