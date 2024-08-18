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

ActiveRecord::Schema[7.1].define(version: 2024_08_18_233414) do
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

  create_table "dests", force: :cascade do |t|
    t.integer "einvoice_id", null: false
    t.string "cnpj"
    t.string "x_nome"
    t.string "ind_ie_dest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["einvoice_id"], name: "index_dests_on_einvoice_id"
  end

  create_table "dets", force: :cascade do |t|
    t.integer "einvoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["einvoice_id"], name: "index_dets_on_einvoice_id"
  end

  create_table "einvoices", force: :cascade do |t|
    t.string "id_nfe"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name"
  end

  create_table "emits", force: :cascade do |t|
    t.integer "einvoice_id", null: false
    t.string "cnpj"
    t.string "x_nome"
    t.string "x_fant"
    t.string "ie"
    t.string "crt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["einvoice_id"], name: "index_emits_on_einvoice_id"
  end

  create_table "ender_dests", force: :cascade do |t|
    t.integer "dest_id", null: false
    t.string "x_lgr"
    t.string "nro"
    t.string "x_bairro"
    t.string "c_mun"
    t.string "x_mun"
    t.string "uf"
    t.string "cep"
    t.string "c_pais"
    t.string "x_pais"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dest_id"], name: "index_ender_dests_on_dest_id"
  end

  create_table "ender_emits", force: :cascade do |t|
    t.integer "emit_id", null: false
    t.string "x_lgr"
    t.string "nro"
    t.string "x_cpl"
    t.string "x_bairro"
    t.string "c_mun"
    t.string "x_mun"
    t.string "uf"
    t.string "cep"
    t.string "c_pais"
    t.string "x_pais"
    t.string "fone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emit_id"], name: "index_ender_emits_on_emit_id"
  end

  create_table "ides", force: :cascade do |t|
    t.integer "einvoice_id", null: false
    t.string "serie"
    t.string "n_nf"
    t.string "dh_emi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["einvoice_id"], name: "index_ides_on_einvoice_id"
  end

  create_table "impostos", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "v_icms"
    t.string "v_ipi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_impostos_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "det_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["det_id"], name: "index_items_on_det_id"
  end

  create_table "prods", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "x_prod"
    t.string "ncm"
    t.string "cfop"
    t.string "u_com"
    t.string "q_com"
    t.string "v_un_com"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_prods_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dests", "einvoices"
  add_foreign_key "dets", "einvoices"
  add_foreign_key "emits", "einvoices"
  add_foreign_key "ender_dests", "dests"
  add_foreign_key "ender_emits", "emits"
  add_foreign_key "ides", "einvoices"
  add_foreign_key "impostos", "items"
  add_foreign_key "items", "dets"
  add_foreign_key "prods", "items"
end
