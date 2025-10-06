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

ActiveRecord::Schema[8.0].define(version: 2025_10_05_035942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "charts", force: :cascade do |t|
    t.integer "sweetness"
    t.integer "freshness"
    t.integer "richness"
    t.integer "calorie"
    t.integer "ingredient_richness"
    t.bigint "ice_cream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "chart_type", default: "official", null: false
    t.index ["ice_cream_id"], name: "index_charts_on_ice_cream_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ice_cream_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ice_cream_id"], name: "index_favorites_on_ice_cream_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "ice_cream_relationships", force: :cascade do |t|
    t.bigint "ice_cream_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ice_cream_id", "tag_id"], name: "index_ice_cream_relationships_on_ice_cream_id_and_tag_id", unique: true
    t.index ["ice_cream_id"], name: "index_ice_cream_relationships_on_ice_cream_id"
    t.index ["tag_id"], name: "index_ice_cream_relationships_on_tag_id"
  end

  create_table "ice_creams", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "arrange"
    t.integer "sweetness"
    t.integer "freshness"
    t.integer "richness"
    t.integer "calorie"
    t.integer "ingredient_richness"
    t.bigint "user_id"
    t.integer "calorie_value"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_ice_creams_on_admin_id"
    t.index ["user_id"], name: "index_ice_creams_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "today_ices", force: :cascade do |t|
    t.bigint "ice_cream_id", null: false
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ice_cream_id"], name: "index_today_ices_on_ice_cream_id"
    t.index ["uuid"], name: "index_today_ices_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "charts", "ice_creams", on_delete: :cascade
  add_foreign_key "favorites", "ice_creams"
  add_foreign_key "favorites", "users"
  add_foreign_key "ice_cream_relationships", "ice_creams"
  add_foreign_key "ice_cream_relationships", "tags"
  add_foreign_key "ice_creams", "admins"
  add_foreign_key "ice_creams", "users"
  add_foreign_key "today_ices", "ice_creams"
end
