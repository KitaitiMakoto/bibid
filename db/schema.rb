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

ActiveRecord::Schema.define(version: 4) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["user_id", "provider"], name: "index_authentications_on_user_id_and_provider", unique: true, using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "title"
    t.string   "epub",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_size",  null: false
  end

  add_index "books", ["epub"], name: "index_books_on_epub", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "display_name", null: false
    t.string   "lower_name",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["lower_name"], name: "index_users_on_lower_name", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree

  add_foreign_key "authentications", "users"
  add_foreign_key "books", "users"
end
