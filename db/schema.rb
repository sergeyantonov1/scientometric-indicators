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

ActiveRecord::Schema.define(version: 20190527110217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "author_profiles", force: :cascade do |t|
    t.string "profile_type", null: false
    t.string "profile_id", null: false
    t.integer "h_index"
    t.integer "author_id", null: false
    t.index ["author_id"], name: "index_author_profiles_on_author_id"
    t.index ["profile_id", "profile_type"], name: "index_author_profiles_on_profile_id_and_profile_type"
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "middle_name"
    t.integer "organization_id", null: false
    t.string "orcid"
    t.datetime "synced_at"
    t.index ["orcid"], name: "index_authors_on_orcid"
    t.index ["organization_id"], name: "index_authors_on_organization_id"
  end

  create_table "organization_profiles", force: :cascade do |t|
    t.string "profile_type", null: false
    t.string "profile_id", null: false
    t.integer "organization_id", null: false
    t.index ["organization_id"], name: "index_organization_profiles_on_organization_id"
    t.index ["profile_id", "profile_type"], name: "index_organization_profiles_on_profile_id_and_profile_type"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "publications_infos", force: :cascade do |t|
    t.integer "publications_count", default: 0, null: false
    t.integer "citations_count", default: 0, null: false
    t.integer "author_profile_id", null: false
    t.string "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_profile_id"], name: "index_publications_infos_on_author_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "users"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
