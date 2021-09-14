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

ActiveRecord::Schema.define(version: 2021_09_02_214602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.string "name"
    t.integer "daycare_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "children_users", id: false, force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_children_users_on_child_id"
    t.index ["user_id"], name: "index_children_users_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "notes"
    t.text "message"
    t.boolean "opt_in_emails"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "source"
  end

  create_table "daycares", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "address"
    t.string "address_two"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.string "stripe_customer_id"
    t.string "email"
    t.string "name"
    t.string "phone"
    t.boolean "delinquent"
    t.integer "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_customer_id"], name: "index_stripe_customers_on_stripe_customer_id"
  end

  create_table "stripe_invoices", force: :cascade do |t|
    t.string "stripe_customer_id"
    t.string "stripe_id"
    t.string "hosted_invoice_url"
    t.integer "total"
    t.boolean "paid"
    t.string "invoice_pdf"
    t.string "collection_method"
    t.string "stripe_subscription_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_customer_id"], name: "index_stripe_invoices_on_stripe_customer_id"
    t.index ["stripe_id"], name: "index_stripe_invoices_on_stripe_id"
    t.index ["stripe_subscription_id"], name: "index_stripe_invoices_on_stripe_subscription_id"
  end

  create_table "stripe_payment_intents", force: :cascade do |t|
    t.integer "amount_recieved"
    t.string "stripe_invoice_id"
    t.string "stripe_id"
    t.string "stripe_customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_customer_id"], name: "index_stripe_payment_intents_on_stripe_customer_id"
    t.index ["stripe_id"], name: "index_stripe_payment_intents_on_stripe_id"
    t.index ["stripe_invoice_id"], name: "index_stripe_payment_intents_on_stripe_invoice_id"
  end

  create_table "stripe_subscriptions", force: :cascade do |t|
    t.string "stripe_customer_id"
    t.string "stripe_id"
    t.datetime "current_period_end"
    t.boolean "cancel_at_period_end"
    t.datetime "current_period_start"
    t.datetime "canceled_at"
    t.datetime "ended_at"
    t.datetime "next_pending_invoice_item_invoice"
    t.jsonb "pending_invoice_item_interval"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_stripe_subscriptions_on_status"
    t.index ["stripe_customer_id"], name: "index_stripe_subscriptions_on_stripe_customer_id"
    t.index ["stripe_id"], name: "index_stripe_subscriptions_on_stripe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "address"
    t.string "address_two"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.integer "kind"
    t.boolean "admin"
    t.integer "daycare_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "stripe_customer_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_customer_id"], name: "index_users_on_stripe_customer_id"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
