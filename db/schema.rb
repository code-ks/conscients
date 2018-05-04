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

ActiveRecord::Schema.define(version: 2018_05_04_092956) do

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

  create_table "addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "zip_code"
    t.string "country", default: "France"
    t.string "title"
    t.integer "address_type", default: 0, null: false
    t.string "email"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_type"], name: "index_addresses_on_address_type"
    t.index ["client_id"], name: "index_addresses_on_client_id"
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

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.string "search_keyword"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "position"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categorizations", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["product_id"], name: "index_categorizations_on_product_id"
  end

  create_table "clients", force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "newsletter_subscriber", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "coupons", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "client_id"
    t.integer "percentage"
    t.integer "amount_cents"
    t.string "amount_currency", default: "EUR", null: false
    t.string "name", null: false
    t.integer "amount_min_order_cents", default: 0, null: false
    t.string "amount_min_order_currency", default: "EUR", null: false
    t.date "valid_from", null: false
    t.date "valid_until", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_coupons_on_client_id"
    t.index ["product_id"], name: "index_coupons_on_product_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.bigint "order_id"
    t.integer "ttc_price_cents", default: 0, null: false
    t.string "ttc_price_currency", default: "EUR", null: false
    t.bigint "tree_plantation_id"
    t.integer "quantity", default: 0, null: false
    t.string "recipient_name"
    t.text "recipient_message"
    t.date "certificate_date"
    t.string "certificate_number"
    t.string "delivery_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_sku_id"], name: "index_line_items_on_product_sku_id"
    t.index ["tree_plantation_id"], name: "index_line_items_on_tree_plantation_id"
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale"
    t.string "key"
    t.string "value"
    t.integer "translatable_id"
    t.string "translatable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale"
    t.string "key"
    t.text "value"
    t.integer "translatable_id"
    t.string "translatable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "aasm_state", null: false
    t.bigint "coupon_id"
    t.bigint "delivery_address_id"
    t.bigint "billing_address_id"
    t.integer "delivery_method", default: 0, null: false
    t.integer "delivery_fees_cents", default: 0, null: false
    t.string "delivery_fees_currency", default: "EUR", null: false
    t.integer "total_price_cents", default: 0, null: false
    t.string "total_price_currency", default: "EUR", null: false
    t.integer "payment_method", default: 0, null: false
    t.text "recipient_message"
    t.text "customer_note"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "stripe_payment_details"
    t.index ["aasm_state"], name: "index_orders_on_aasm_state"
    t.index ["billing_address_id"], name: "index_orders_on_billing_address_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["delivery_address_id"], name: "index_orders_on_delivery_address_id"
    t.index ["delivery_method"], name: "index_orders_on_delivery_method"
    t.index ["payment_method"], name: "index_orders_on_payment_method"
  end

  create_table "product_skus", force: :cascade do |t|
    t.bigint "product_id"
    t.string "sku", null: false
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_skus_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.text "description"
    t.integer "ht_price_cents", default: 0, null: false
    t.string "ht_price_currency", default: "EUR", null: false
    t.decimal "tax_rate", precision: 4, scale: 2, default: "20.0", null: false
    t.integer "weight", default: 0
    t.integer "product_type", default: 0, null: false
    t.boolean "published", default: true, null: false
    t.integer "position"
    t.integer "ht_buying_price_cents", default: 0, null: false
    t.string "ht_buying_price_currency", default: "EUR", null: false
    t.string "seo_title"
    t.string "meta_description"
    t.text "keywords", default: [], array: true
    t.string "slug"
    t.decimal "producer_latitude", precision: 11, scale: 8
    t.decimal "producer_longitude", precision: 11, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
    t.string "name_fr"
    t.index ["ht_price_cents"], name: "index_products_on_ht_price_cents"
    t.index ["name_en"], name: "index_products_on_name_en"
    t.index ["name_fr"], name: "index_products_on_name_fr"
    t.index ["product_type"], name: "index_products_on_product_type"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["tax_rate"], name: "index_products_on_tax_rate"
    t.index ["weight"], name: "index_products_on_weight"
  end

  create_table "stock_entries", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_sku_id"], name: "index_stock_entries_on_product_sku_id"
  end

  create_table "tree_plantations", force: :cascade do |t|
    t.string "project_name", null: false
    t.string "project_type"
    t.string "partner", null: false
    t.string "plantation_uuid", null: false
    t.string "base_certificate_uuid", null: false
    t.decimal "latitude", precision: 11, scale: 8, null: false
    t.decimal "longitude", precision: 11, scale: 8, null: false
    t.string "tree_specie", null: false
    t.string "producer_name", null: false
    t.integer "trees_quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variabilizations", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.bigint "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_sku_id"], name: "index_variabilizations_on_product_sku_id"
    t.index ["variant_id"], name: "index_variabilizations_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.integer "category", default: 0, null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  add_foreign_key "addresses", "clients"
  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "products"
  add_foreign_key "coupons", "clients"
  add_foreign_key "coupons", "products"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "product_skus"
  add_foreign_key "line_items", "tree_plantations"
  add_foreign_key "orders", "addresses", column: "billing_address_id"
  add_foreign_key "orders", "addresses", column: "delivery_address_id"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "coupons"
  add_foreign_key "product_skus", "products"
  add_foreign_key "stock_entries", "product_skus"
  add_foreign_key "variabilizations", "product_skus"
  add_foreign_key "variabilizations", "variants"
end
