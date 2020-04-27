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

ActiveRecord::Schema.define(version: 2020_04_27_160415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, default: "My custom category"
    t.string "icon", limit: 255, default: "my_custom_category.svg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_transactions", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "transaction_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_categories_transactions_on_category_id"
    t.index ["transaction_id"], name: "index_categories_transactions_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "name", limit: 255, default: "My transaction", null: false
    t.text "description", default: "", null: false
    t.decimal "amount", precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_transactions_on_author_id"
    t.index ["name"], name: "index_transactions_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories_transactions", "categories"
  add_foreign_key "categories_transactions", "transactions"
  add_foreign_key "transactions", "users", column: "author_id"
end
