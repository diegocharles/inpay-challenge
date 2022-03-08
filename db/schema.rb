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

ActiveRecord::Schema[7.0].define(version: 2022_03_07_232952) do
  create_table "payments", force: :cascade do |t|
    t.string "receiver_full_name", null: false
    t.string "currency", default: "EUR", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.decimal "fees_amount", precision: 8, scale: 2, default: "0.0"
    t.string "status", default: "pending", null: false
    t.string "payment_method", null: false
    t.integer "escrow", default: 0
    t.string "uuid", null: false
    t.datetime "sent_at"
    t.datetime "received_at"
    t.datetime "failed_at"
    t.string "iban"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_payments_on_uuid"
  end

end
