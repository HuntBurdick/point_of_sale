# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131108064926) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "user_type"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "custom_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "quantity",                                  :default => 1
    t.integer  "sale_id"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.decimal  "total_price", :precision => 8, :scale => 2
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "bike_customer"
    t.boolean  "public_service"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "sku"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",                  :precision => 8, :scale => 2
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.integer  "stock_amount"
    t.string   "status"
    t.string   "vendor"
    t.decimal  "cost_price",             :precision => 8, :scale => 2
    t.decimal  "price_override",         :precision => 8, :scale => 2
    t.boolean  "custom_item"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "quantity",                                    :default => 1
    t.integer  "sale_id"
    t.integer  "work_order_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.decimal  "price",         :precision => 8, :scale => 2
    t.decimal  "total_price",   :precision => 8, :scale => 2
  end

  create_table "sales", :force => true do |t|
    t.decimal  "total_amount",        :precision => 8, :scale => 2
    t.decimal  "tax_amount",          :precision => 8, :scale => 2
    t.boolean  "paid"
    t.decimal  "amount_paid"
    t.string   "payment_type"
    t.integer  "customer_id"
    t.text     "comments"
    t.boolean  "sale"
    t.boolean  "sale_refunded"
    t.boolean  "work_order"
    t.boolean  "work_order_called"
    t.string   "item_1"
    t.text     "item_1_description"
    t.string   "item_2"
    t.text     "item_2_description"
    t.string   "item_3"
    t.text     "item_3_description"
    t.date     "dropped_off_date"
    t.date     "promised_by_date"
    t.boolean  "special_order"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.boolean  "quick_sale"
    t.boolean  "create_new_customer"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "bike_customer"
    t.boolean  "public_service"
    t.boolean  "reservation"
    t.boolean  "pending_parts"
    t.boolean  "layaway"
    t.boolean  "work_order_done"
  end

  create_table "work_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "sale_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
