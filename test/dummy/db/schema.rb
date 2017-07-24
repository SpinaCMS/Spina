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

ActiveRecord::Schema.define(version: 20170724115131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "spina_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.text     "preferences"
    t.string   "logo"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "kvk_identifier"
    t.string   "vat_identifier"
    t.boolean  "robots_allowed", default: false
  end

  create_table "spina_attachment_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_attachment_collections_attachments", force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_layout_parts", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "layout_partable_id"
    t.string   "layout_partable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "spina_line_translations", force: :cascade do |t|
    t.integer  "spina_line_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "content"
    t.index ["locale"], name: "index_spina_line_translations_on_locale", using: :btree
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id", using: :btree
  end

  create_table "spina_lines", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_navigation_items", force: :cascade do |t|
    t.integer  "page_id",                   null: false
    t.integer  "navigation_id",             null: false
    t.integer  "position",      default: 0, null: false
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true, using: :btree
  end

  create_table "spina_navigations", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "label",                          null: false
    t.boolean  "auto_add_pages", default: false, null: false
    t.integer  "position",       default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true, using: :btree
  end

  create_table "spina_options", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_page_parts", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "page_id"
    t.integer  "page_partable_id"
    t.string   "page_partable_type"
  end

  create_table "spina_page_translations", force: :cascade do |t|
    t.integer  "spina_page_id",     null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.string   "menu_title"
    t.string   "description"
    t.string   "seo_title"
    t.string   "materialized_path"
    t.index ["locale"], name: "index_spina_page_translations_on_locale", using: :btree
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id", using: :btree
  end

  create_table "spina_pages", force: :cascade do |t|
    t.string   "title"
    t.string   "menu_title"
    t.string   "description"
    t.boolean  "show_in_menu",        default: true
    t.string   "slug"
    t.boolean  "deletable",           default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "seo_title"
    t.boolean  "skip_to_first_child", default: false
    t.string   "view_template"
    t.string   "layout_template"
    t.boolean  "draft",               default: false
    t.string   "link_url"
    t.string   "ancestry"
    t.integer  "position"
    t.string   "materialized_path"
    t.boolean  "active",              default: true
  end

  create_table "spina_photo_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_photo_collections_photos", force: :cascade do |t|
    t.integer "photo_collection_id"
    t.integer "photo_id"
    t.integer "position"
  end

  create_table "spina_photos", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_rewrite_rules", force: :cascade do |t|
    t.string   "old_path"
    t.string   "new_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_structure_items", force: :cascade do |t|
    t.integer  "structure_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id", using: :btree
  end

  create_table "spina_structure_parts", force: :cascade do |t|
    t.integer  "structure_item_id"
    t.integer  "structure_partable_id"
    t.string   "structure_partable_type"
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id", using: :btree
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id", using: :btree
  end

  create_table "spina_structures", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_text_translations", force: :cascade do |t|
    t.integer  "spina_text_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "content"
    t.index ["locale"], name: "index_spina_text_translations_on_locale", using: :btree
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id", using: :btree
  end

  create_table "spina_texts", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "last_logged_in"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
