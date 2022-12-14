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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_175300) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "santa_list_participants", force: :cascade do |t|
    t.bigint "list_id_id"
    t.bigint "sender_id_id"
    t.bigint "receiver_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id_id"], name: "index_santa_list_participants_on_list_id_id"
    t.index ["receiver_id_id"], name: "index_santa_list_participants_on_receiver_id_id"
    t.index ["sender_id_id"], name: "index_santa_list_participants_on_sender_id_id"
  end

  create_table "secret_santa_lists", force: :cascade do |t|
    t.bigint "organizer_id"
    t.text "list_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_secret_santa_lists_on_organizer_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "user_name"
    t.text "password"
    t.text "wish_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "santa_list_participants", "secret_santa_lists", column: "list_id_id"
  add_foreign_key "santa_list_participants", "users", column: "receiver_id_id"
  add_foreign_key "santa_list_participants", "users", column: "sender_id_id"
  add_foreign_key "secret_santa_lists", "users", column: "organizer_id"
end
