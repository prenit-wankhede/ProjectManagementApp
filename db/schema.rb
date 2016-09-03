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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160902200307) do

  create_table "project_developers", force: :cascade do |t|
    t.integer  "project_id",   limit: 4
    t.integer  "developer_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_name",        limit: 255, default: ""
    t.string   "project_description", limit: 255, default: ""
    t.integer  "project_manager_id",  limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "todo_task_developers", force: :cascade do |t|
    t.integer  "todo_task_id", limit: 4
    t.integer  "developer_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "todo_tasks", force: :cascade do |t|
    t.string   "task_name",        limit: 255, default: ""
    t.string   "task_description", limit: 255, default: ""
    t.string   "task_status",      limit: 255, default: "New"
    t.integer  "project_id",       limit: 4
    t.integer  "task_creator_id",  limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",          null: false
    t.string   "encrypted_password",     limit: 255, default: "",          null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "oauth_provider",         limit: 255
    t.string   "oauth_uid",              limit: 255
    t.string   "first_name",             limit: 255, default: ""
    t.string   "last_name",              limit: 255, default: ""
    t.string   "role",                   limit: 255, default: "Developer"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
