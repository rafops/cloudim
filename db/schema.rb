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

ActiveRecord::Schema.define(version: 20171011023650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "profile", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accounts_on_name", unique: true
  end

  create_table "db_instances", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instances", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "region", null: false
    t.string "name", default: "", null: false
    t.string "image_id", default: "", null: false
    t.string "instance_id", null: false
    t.string "instance_type", default: "", null: false
    t.string "key_name", default: "", null: false
    t.string "private_dns_name", default: "", null: false
    t.string "private_ip_address", default: "", null: false
    t.string "public_dns_name", default: "", null: false
    t.string "public_ip_address", default: "", null: false
    t.string "state_transition_reason", default: "", null: false
    t.string "subnet_id", default: "", null: false
    t.string "vpc_id", default: "", null: false
    t.string "architecture", default: "", null: false
    t.string "client_token", default: "", null: false
    t.string "hypervisor", default: "", null: false
    t.string "root_device_name", default: "", null: false
    t.string "root_device_type", default: "", null: false
    t.string "virtualization_type", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "valid_until", default: "Infinity", null: false
    t.index ["account_id"], name: "index_instances_on_account_id"
    t.index ["region"], name: "index_instances_on_region"
    t.index ["instance_id", "valid_until"], name: "index_instances_on_instance_id_and_valid_until", unique: true
  end

end
