# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_02_223906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.text "plot"
    t.integer "number"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title", "number"], name: "index_contents_on_title_and_number", unique: true
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.string "title", null: false
    t.text "plot", null: false
    t.integer "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_episodes_on_content_id"
  end

  create_table "purchase_options", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.string "quality", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_purchase_options_on_content_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "content_id", null: false
    t.bigint "purchase_option_id", null: false
    t.boolean "expired", default: false, null: false
    t.string "expiration_jid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_purchases_on_content_id"
    t.index ["purchase_option_id"], name: "index_purchases_on_purchase_option_id"
    t.index ["user_id", "content_id"], name: "index_purchases_on_user_id_and_content_id", unique: true, where: "(expired = false)"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "episodes", "contents"
  add_foreign_key "purchase_options", "contents"
  add_foreign_key "purchases", "contents"
  add_foreign_key "purchases", "purchase_options"
  add_foreign_key "purchases", "users"
end
