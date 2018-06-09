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

ActiveRecord::Schema.define(version: 5) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true
    t.index ["user_id", "provider"], name: "index_authentications_on_user_id_and_provider", unique: true
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "epub", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "file_size", null: false
    t.string "unique_identifier"
    t.text "description"
    t.string "language"
    t.index ["epub"], name: "index_books_on_epub", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "lower_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lower_name"], name: "index_users_on_lower_name"
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "books", "users"
end
