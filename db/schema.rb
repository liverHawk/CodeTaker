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

ActiveRecord::Schema[8.1].define(version: 2026_03_12_080000) do
  create_table "invite_ids", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "invite_id", null: false
    t.datetime "updated_at", null: false
    t.boolean "used", default: false, null: false
    t.integer "user_id"
    t.index ["invite_id"], name: "index_invite_ids_on_invite_id", unique: true
    t.index ["user_id"], name: "index_invite_ids_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "confirmed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "name", default: ""
    t.string "provider", default: ""
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.string "submitted_email", default: ""
    t.string "uid", default: ""
    t.datetime "updated_at", null: false
    t.string "url", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, where: "provider != '' AND uid != ''"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["url"], name: "index_users_on_url"
  end

  add_foreign_key "invite_ids", "users"
end
